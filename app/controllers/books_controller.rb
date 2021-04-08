class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @pending_books = Book.where.not(is_confirmed: true)
    @confirmed_books = Book.where(is_confirmed: true)
  end

  # GET /books/1 or /books/1.json
  def show
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
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        BookMailer.with(book: @book).book_pending_customer.deliver_now
        BookMailer.with(book: @book).book_pending_admin.deliver_now
        format.html { redirect_to @book, notice: "Reserva realizada." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update

    if book_params[:is_confirmed]
      BookMailer.with(book: @book).book_confirmation.deliver_now
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
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Reserva eliminada." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:email, :start_time, :diners, :is_confirmed)
    end
end
