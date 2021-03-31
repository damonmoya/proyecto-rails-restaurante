require "rails_helper"

RSpec.describe BookMailer, type: :mailer do
  describe 'books' do
    let(:book) { Book.create!(
      email: "prueba1@gmail.com",
      start_time: "2021-04-22 14:32:00 UTC"

    ) }
    let(:mail) { BookMailer.with(book: book).book_confirmation }

    it 'renders the subject' do
      expect(mail.subject).to eq('Reserva confirmada')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([book.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['mirestaurante@example.com'])
    end

    it 'assigns @email' do
      expect(mail.body.encoded).to match(book.email)
    end

    it 'assigns @start_time' do
      expect(mail.body.encoded).to match(book.start_time)
    end

  end
end
