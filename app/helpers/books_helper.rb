module BooksHelper
    def state_book(book)
      if book.state == "pending"
        "Pendiente"
      elsif book.state == "confirmed"
        "Confirmada"
      elsif book.state == "no_show"
        "No presentada" 
      end
    end
end
