require "rails_helper"

RSpec.describe BookMailer, type: :mailer do
  describe 'pending email for customer' do
    let(:book) { Book.create!(
      email: "prueba1@gmail.com",
      start_time: "2021-04-22 14:32:00 UTC",
      diners: 1,
      state: 0
    ) }
    let(:mail) { BookMailer.with(book: book).book_pending_customer }

    it 'receives pending book' do
      expect(book.state).to eq(0)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Reserva pendiente de confirmar')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([book.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['mirestaurante@example.com'])
    end

    it 'renders email body headers' do
      expect(mail.body.encoded).to match(/Su reserva se encuentra a la espera de confirmaci=C3=B3n./)
      expect(mail.body.encoded).to match(/Estos son los datos de la reserva:/)
    end

    it 'assigns @email' do
      expect(mail.body.encoded).to match(/Email: prueba1@gmail.com/)
    end

    it 'assigns @start_time' do
      expect(mail.body.encoded).to match(/Fecha y Hora: 2021-04-22 14:32:00 UTC/)
    end

    it 'assigns @diners' do
      expect(mail.body.encoded).to match(/Comensales: 1/)
    end

    it 'renders email closing text' do
      expect(mail.body.encoded).to match(/Se le enviar=C3=A1 un correo en cuanto su reserva quede confirmada./)
    end

  end

  describe 'pending email for admin' do
    let(:book) { Book.create!(
      email: "prueba1@gmail.com",
      start_time: "2021-04-22 14:32:00 UTC",
      diners: 1,
      state: 0
    ) }
    let(:mail) { BookMailer.with(book: book).book_pending_admin }

    it 'receives pending book' do
      expect(book.state).to eq(0)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Reserva pendiente de confirmar')
    end

    #it 'renders the receiver email' do
    #  expect(mail.to).to eq([@admin_email])
    #end

    it 'renders the sender email' do
      expect(mail.from).to eq(['mirestaurante@example.com'])
    end

    it 'renders email body headers' do
      expect(mail.body.encoded).to match(/Una nueva reserva se encuentra a la espera de confirmaci=C3=B3n./)
      expect(mail.body.encoded).to match(/Estos son los datos de la reserva:/)
    end

    it 'assigns @email' do
      expect(mail.body.encoded).to match(/Email: prueba1@gmail.com/)
    end

    it 'assigns @start_time' do
      expect(mail.body.encoded).to match(/Fecha y Hora: 2021-04-22 14:32:00 UTC/)
    end

    it 'assigns @diners' do
      expect(mail.body.encoded).to match(/Comensales: 1/)
    end

    it 'renders email closing text' do
      expect(mail.body.encoded).to match(/Puede confirmar la reserva a trav=C3=A9s de la aplicaci=C3=B3n web./)
    end

  end

  describe 'confirmation email' do
    let(:book) { Book.create!(
      email: "prueba3@gmail.com",
      start_time: "2021-06-22 14:32:00 UTC",
      diners: 4,
      state: 1
    ) }
    let(:mail) { BookMailer.with(book: book).book_confirmation }

    it 'receives confirmed book' do
      expect(book.state).to eq(1)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Reserva confirmada')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([book.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['mirestaurante@example.com'])
    end

    it 'renders email body headers' do
      expect(mail.body.encoded).to match(/Su reserva ha sido confirmada./)
      expect(mail.body.encoded).to match(/Estos son los datos de su reserva:/)
    end

    it 'assigns @email' do
      expect(mail.body.encoded).to match(/Email: prueba3@gmail.com/)
    end

    it 'assigns @start_time' do
      expect(mail.body.encoded).to match(/Fecha y Hora: 2021-06-22 14:32:00 UTC/)
    end

    it 'assigns @diners' do
      expect(mail.body.encoded).to match(/Comensales: 4/)
    end

    it 'renders email closing text' do
      expect(mail.body.encoded).to match(/Le esperamos en nuestro restaurante./)
    end

  end
end
