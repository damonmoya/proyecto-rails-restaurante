class RestaurantController < ApplicationController

  def index
    @book = Book.new
  end

  def getBooks

    books = Book.where(email: book_params[:email])

    if books.count == 0 
      msg = "¡No hay reservas correspondientes a " + book_params[:email] + "!"
      respond_to do |format|
        format.html { redirect_to restaurant_index_path, alert: msg }
        format.json { render :index, location: restaurant_index_path }
      end
      return
    end

    @check = Check.new(email: book_params[:email], expire_time: (DateTime.now + (1.0/48)))
    @check.save 

    url = request.base_url + "/books/mybooks?token=" + @check.token

    BookMailer.with(email: book_params[:email], url: url).mybooks.deliver_now

    msg = "¡Correo con enlace enviado a " + book_params[:email] + "! El enlace es válido durante los próximos 30 minutos"

    respond_to do |format|
      format.html { redirect_to restaurant_index_path, notice: msg }
      format.json { render :index, location: restaurant_index_path }
    end
  end

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
          BookMailer.with(book: @book).book_pending_customer.deliver_now
          BookMailer.with(book: @book).book_pending_admin.deliver_now
          format.html { redirect_to @book, notice: "Reserva realizada." }
          format.json { render 'books/show', status: :created, location: @book }
        else
          format.html { render :index, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private 
    # Only allow a list of trusted parameters through.
    def book_params
      params.permit(:email, :start_time, :diners, :state, :charge)
    end

end
