# Preview all emails at http://localhost:3000/rails/mailers/book_mailer
class BookMailerPreview < ActionMailer::Preview
    def book_confirmation
      # Set up a temporary book for the preview
      book = Book.new(email: "email1@gmail.com", start_time: "2021-07-30 14:32:00 UTC", diners: 2, is_confirmed: true)
      BookMailer.with(book: book).book_confirmation
    end

    def book_pending_customer
      # Set up a temporary book for the preview
      book = Book.new(email: "email2@gmail.com", start_time: "2021-08-30 14:32:00 UTC", diners: 2, is_confirmed: false)
      BookMailer.with(book: book).book_pending_customer
    end

    def book_pending_admin
      # Set up a temporary book for the preview
      book = Book.new(email: "email3@gmail.com", start_time: "2021-09-30 14:32:00 UTC", diners: 2, is_confirmed: false)
      BookMailer.with(book: book).book_pending_admin
    end
end
