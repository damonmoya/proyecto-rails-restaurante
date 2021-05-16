require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books_all, [
      Book.create!(
        email: "email1@hotmail.com",
        start_time: "2021-04-22 14:32:00 UTC",
        diners: 2,
        state: 0
      ),
      Book.create!(
        email: "email2@gmail.com",
        start_time: "2021-05-30 14:32:00 UTC",
        diners: 4,
        state: 0
      ),
      Book.create!(
        email: "email3@hotmail.com",
        start_time: "2022-04-22 14:32:00 UTC",
        diners: 2,
        state: 1
      ),
      Book.create!(
        email: "email4@gmail.com",
        start_time: "2022-05-30 14:32:00 UTC",
        diners: 3,
        state: 3,
        charge: Money.new(500, "EUR")
      )
    ])
    assign(:books, [
      Book.create!(
        email: "email1@hotmail.com",
        start_time: "2021-04-22 14:32:00 UTC",
        diners: 2,
        state: 0
      ),
      Book.create!(
        email: "email2@gmail.com",
        start_time: "2021-05-30 14:32:00 UTC",
        diners: 4,
        state: 0
      ),
      Book.create!(
        email: "email3@hotmail.com",
        start_time: "2022-04-22 14:32:00 UTC",
        diners: 2,
        state: 1
      ),
      Book.create!(
        email: "email4@gmail.com",
        start_time: "2022-05-30 14:32:00 UTC",
        diners: 3,
        state: 3,
        charge: Money.new(500, "EUR")
      )
    ])
  end

  it "renders a list of books" do
    allow(view).to receive_messages(:will_paginate => nil)
    render
    assert_select "h1", text: "Reservas".to_s
    assert_select "table", count: 1
    assert_select "tr", count: 5
    ###########################
    assert_select "tr>th", text: "Email".to_s, count: 1
    assert_select "tr>th", text: "Fecha y hora".to_s, count: 1
    assert_select "tr>th", text: "Comensales".to_s, count: 1
    assert_select "tr>th", text: "Estado".to_s, count: 1
    assert_select "tr>th", text: "Cargo".to_s, count: 1
    assert_select "tr>th", text: "Acciones".to_s, count: 1
    ###########################
    assert_select "tr>td", text: "email1@hotmail.com".to_s, count: 1
    assert_select "tr>td", text: "2021-04-22 14:32:00 UTC".to_s, count: 1
    assert_select "tr>td", text: 2.to_s, count: 2
    ###########################
    assert_select "tr>td", text: "email2@gmail.com".to_s, count: 1
    assert_select "tr>td", text: "2021-05-30 14:32:00 UTC".to_s, count: 1
    assert_select "tr>td", text: 4.to_s, count: 1
    ###########################
    assert_select "tr>td", text: "email3@hotmail.com".to_s, count: 1
    assert_select "tr>td", text: "2022-04-22 14:32:00 UTC".to_s, count: 1
    ###########################
    assert_select "tr>td", text: "email4@gmail.com".to_s, count: 1
    assert_select "tr>td", text: "2022-05-30 14:32:00 UTC".to_s, count: 1
    assert_select "tr>td", text: 3.to_s, count: 1
    ###########################
    assert_select "tr>td", text: "Pendiente".to_s, count: 2
    assert_select "tr>td", text: "Confirmada".to_s, count: 1
    assert_select "tr>td", text: "A pagar".to_s, count: 1
    ###########################
    assert_select "tr>td", text: "Sin cargo".to_s, count: 3
    assert_select "tr>td", text: "5.00€".to_s, count: 1
    ###########################
  end
end

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books_all, [])
  end

  it "renders no books" do
    render
    assert_select "h1", text: "Reservas".to_s
    assert_select "table", count: 0
    assert_select "p", text: "¡No hay reservas!".to_s, count: 1
  end
end
