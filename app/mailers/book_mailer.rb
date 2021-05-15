class BookMailer < ApplicationMailer
    default from: 'notificaciones.restauranterails@gmail.com'

    def book_pending_customer
      @book = params[:book]
      @customer_email = @book.email
      mail(to: @customer_email, subject: 'Reserva pendiente de confirmar')
    end

    def book_pending_admin
      @book = params[:book]
      @admin_email = "notificaciones.restauranterails@gmail.com"
      mail(to: @admin_email, subject: 'Reserva pendiente de confirmar')
    end

    def book_confirmation
      @book = params[:book]
      mail(to: @book.email, subject: 'Reserva confirmada')
    end

    def mybooks
      @email = params[:email]
      @url = params[:url]
      mail(to: @email, subject: 'Consulta de sus reservas')
    end

    def reminder_book
      @book = params[:book]
      mail(to: @book.email, subject: 'Recordatorio de reserva')
    end

    def cancelled_book
      @book = params[:book]
      mail(to: @book.email, subject: 'Reserva cancelada')
    end
end
