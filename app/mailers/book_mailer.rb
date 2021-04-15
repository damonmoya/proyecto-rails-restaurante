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
end
