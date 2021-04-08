json.extract! book, :id, :email, :start_time, :diners, :is_confirmed, :created_at, :updated_at
json.url book_url(book, format: :json)
