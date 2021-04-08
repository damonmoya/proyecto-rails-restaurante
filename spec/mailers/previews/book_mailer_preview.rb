# Preview all emails at http://localhost:3000/rails/mailers/book_mailer
class BookMailerPreview < ActionMailer::Preview
    def book_confirmation
        # Set up a temporary book for the preview
        book = Book.new(email: "email1@gmail.com", start_time: "2021-07-30 14:32:00 UTC", diners: 1, is_confirmed: false)
    
        BookMailer.with(book: book).book_confirmation
      end
end
