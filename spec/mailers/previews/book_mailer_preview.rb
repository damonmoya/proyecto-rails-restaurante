# Preview all emails at http://localhost:3000/rails/mailers/book_mailer
class BookMailerPreview < ActionMailer::Preview
    def book_confirmation
      # Set up a temporary book for the preview
      book = Book.new(email: "email1@gmail.com", start_time: "2021-07-30 14:32:00 UTC", diners: 2, state: "confirmed")
      BookMailer.with(book: book).book_confirmation
    end

    def book_pending_customer
      # Set up a temporary book for the preview
      book = Book.new(email: "email2@gmail.com", start_time: "2021-08-30 14:32:00 UTC", diners: 2, state: "pending")
      BookMailer.with(book: book).book_pending_customer
    end

    def book_pending_admin
      # Set up a temporary book for the preview
      book = Book.new(email: "email3@gmail.com", start_time: "2021-09-30 14:32:00 UTC", diners: 2, state: "pending")
      BookMailer.with(book: book).book_pending_admin
    end

    def mybook
      @email = "email4@gmail.com"
      @url = "http://localhost:3000/books/mybooks?email=ZGFtb245OUBob3RtYWlsLmVz"
      BookMailer.with(email: @email, url: @url).mybook
    end

    def reminder_book
      book = Book.new(email: "email5@gmail.com", start_time: "2021-09-30 14:32:00 UTC", diners: 2, state: "confirmed")
      BookMailer.with(book: book).reminder_book
    end

    def cancelled_book
      book = Book.new(email: "email5@gmail.com", start_time: "2021-09-30 14:32:00 UTC", diners: 2, state: "confirmed")
      BookMailer.with(book: book).cancelled_book
    end
end
