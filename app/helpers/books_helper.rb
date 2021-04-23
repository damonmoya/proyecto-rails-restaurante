module BooksHelper
    def state_book(book)
      if book.state == "pending"
        "Pendiente"
      elsif book.state == "confirmed"
        "Confirmada"
      elsif book.state == "no_show"
        "No presentada" 
      elsif book.state == "to_pay"
        "A pagar" 
      end
    end

    def charge_book(book)
      charge = "Sin cargo"
      if book.charge != nil
        charge = book.charge.to_s + "€"
      end
      charge
    end
end
