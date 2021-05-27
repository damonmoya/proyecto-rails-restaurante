class BooksController < ApplicationController
  require 'recaptcha.rb'

  rescue_from Stripe::CardError, with: :catch_exception
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :verify_pay_recaptcha, only: [:checkout]
  before_action :authenticate_admin!, except: [:show, :pay, :checkout, :mybooks, :new, :create, :cancel]
  helper_method :sort_column, :sort_direction

  # GET /books or /books.json
  def index
    order = sort_column + " " + sort_direction
    @books_all = Book.paginate(page: params[:page], per_page: 10).order(order)
    if (params[:search] != nil)
      @books = Book.paginate(page: params[:page], per_page: 10).where("email LIKE ?", "%#{params[:search]}%").order(order)
    else 
      @books = @books_all
    end
  end

  # GET /books/1 or /books/1.json
  def show
  end

  def pay
    if (params[:email] == nil || params[:diners] == nil ||
      params[:start_time_1i] == nil || params[:start_time_2i] == nil || 
      params[:start_time_3i] == nil || params[:start_time_4i] == nil || 
      params[:start_time_5i] == nil)
      respond_to do |format|
        format.html { redirect_to books_url}
        format.json { head :no_content }
      end
    end
    @email = params[:email]
    @diners = params[:diners]
    @start_time_1i = params[:start_time_1i]
    @start_time_2i = params[:start_time_2i]
    @start_time_3i = params[:start_time_3i]
    @start_time_4i = params[:start_time_4i]
    @start_time_5i = params[:start_time_5i]
    @notice = params[:notice]
  end

  def checkout
    datetime=DateTime.civil(params[:start_time_1i].to_i, params[:start_time_2i].to_i, params[:start_time_3i].to_i,
      params[:start_time_4i].to_i, params[:start_time_5i].to_i,)
    @book = Book.new(
      email: params[:email], 
      diners: params[:diners],
      start_time: datetime,
      state: "pending",
      charge: Money.new(500, "EUR")
    )

    if @book.save

      BookMailer.with(book: @book).book_pending_customer.deliver_later
      BookMailer.with(book: @book).book_pending_admin.deliver_later

      respond_to do |format|
        format.html { redirect_to root_url, notice: "Reserva pagada." }
        format.json { render :action => 'index', :controller => 'restaurant' }
      end

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => 500,
        :description => 'Book charge',
        :currency => 'eur'
      )

    end

  end

  def mybooks
    @date_now = DateTime.now.utc.to_i

    @check = Check.find_by token: params[:token]
    if @check != nil
      if ((@check.expire_time.to_i - @date_now)) < 0
        respond_to do |format|
          format.html { redirect_to restaurant_index_path, alert: "La solicitud ha expirado" }
          format.json { render :index, location: restaurant_index_path }
        end
      end
      @token = params[:token]
      @email = @check.email
      @grace_time = 3*(60*60*24)
      order = sort_column + " " + sort_direction
      @books = Book.paginate(page: params[:page], per_page: 10).where(email: @email).order(order)
    else 
      respond_to do |format|
        format.html { redirect_to restaurant_index_path, alert: "Ninguna solicitud encontrada" }
        format.json { render :index, location: restaurant_index_path }
      end
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create

    # Check if email is blacklisted
    @books = Book.all
    @blacklisted_books = Book.where(state: "no_show", email: book_params[:email])
    
    respond_to do |format|
      if @blacklisted_books.count > 0 
        
        format.html { redirect_to pay_books_path(
          email: book_params[:email], 
          diners: book_params[:diners],
          start_time_1i: book_params["start_time(1i)"], 
          start_time_2i: book_params["start_time(2i)"], 
          start_time_3i: book_params["start_time(3i)"], 
          start_time_4i: book_params["start_time(4i)"], 
          start_time_5i: book_params["start_time(5i)"] 
        ) }
        format.json { render :pay, status: :created, location: pay_books_path }
      else
        @book = Book.new(book_params)
        if @book.save
          BookMailer.with(book: @book).book_pending_customer.deliver_later
          BookMailer.with(book: @book).book_pending_admin.deliver_later
          format.html { redirect_to @book, notice: "Reserva realizada." }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    if book_params[:state] === "confirmed" && @book.state === "pending"
      BookMailer.with(book: @book).book_confirmation.deliver_later
    end
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Reserva actualizada." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    BookMailer.with(book: @book).cancelled_book.deliver_now
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, alert: "Reserva eliminada." }
      format.json { head :no_content }
    end
  end

  def cancel
    check = Check.find_by token: params[:token]
    book = Book.find(params[:id])
    if check.email == book.email
      BookMailer.with(book: book).cancelled_book.deliver_now
      book.destroy
      respond_to do |format|
        format.html { redirect_to root_url, alert: "Reserva cancelada." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:email, :start_time, :diners, :state, :charge)
    end
  
    def catch_exception(exception)
      flash[:error] = exception.message
    end

    def verify_pay_recaptcha
      if params["g-recaptcha-response"] == ""
        respond_to do |format|
          format.html { redirect_to pay_books_path(
            email: params[:email], 
            diners: params[:diners],
            start_time_1i: params[:start_time_1i], 
            start_time_2i: params[:start_time_2i], 
            start_time_3i: params[:start_time_3i], 
            start_time_4i: params[:start_time_4i], 
            start_time_5i: params[:start_time_5i],
            notice: "No se ha validado el Captcha"
          )}
          format.json { render :pay, location: pay_books_path }
        end
      end
    end

    def sort_column
      params[:sort] || "email"
    end

    def sort_direction
      params[:direction] || "asc"
    end

    def authenticate_admin!
      if admin_signed_in?
        super
      else
        respond_to do |format|
          format.html { redirect_to root_url}
          format.json { head :no_content }
        end
      end
    end

end
