class BookMailer < ApplicationMailer
    default from: 'mirestaurante@example.com'

    def book_confirmation
      @book = params[:book]
      mail(to: @book.email, subject: 'Reserva confirmada')
    end
end
