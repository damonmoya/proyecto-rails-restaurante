require 'rails_helper'

RSpec.describe "books/mybooks", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        email: "prueba@gmail.com",
        start_time: "2021-04-22 14:32:00 UTC",
        diners: 2,
        state: 0
      ),
      Book.create!(
        email: "prueba@gmail.com",
        start_time: "2021-05-30 14:32:00 UTC",
        diners: 4,
        state: 0
      ),
      Book.create!(
        email: "prueba@gmail.com",
        start_time: "2022-04-22 14:32:00 UTC",
        diners: 2,
        state: 1
      ),
      Book.create!(
        email: "prueba@gmail.com",
        start_time: "2022-05-30 14:32:00 UTC",
        diners: 3,
        state: 3,
        charge: Money.new(500, "EUR")
      )
    ]);
    assign(:date_now, DateTime.now.utc.to_i);
    assign(:grace_time, 3*(60*60*24));
  end

  it "renders a list of books" do
    allow(view).to receive_messages(:will_paginate => nil)
    render
    assert_select "table", count: 1
    assert_select "tr", count: 5
    ###########################
    assert_select "tr>th", text: "Fecha y hora".to_s, count: 1
    assert_select "tr>th", text: "Comensales".to_s, count: 1
    assert_select "tr>th", text: "Estado".to_s, count: 1
    assert_select "tr>th", text: "Cargo".to_s, count: 1
    assert_select "tr>th", text: "Acciones".to_s, count: 1
    ###########################
    assert_select "tr>td", text: "2021-04-22 14:32:00 UTC".to_s, count: 1
    assert_select "tr>td", text: 2.to_s, count: 2
    ###########################
    assert_select "tr>td", text: "2021-05-30 14:32:00 UTC".to_s, count: 1
    assert_select "tr>td", text: 4.to_s, count: 1
    ###########################
    assert_select "tr>td", text: "2022-04-22 14:32:00 UTC".to_s, count: 1
    ###########################
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

RSpec.describe "books/mybooks", type: :view do
  before(:each) do
    assign(:books, [])
  end

  it "renders no books" do
    render
    assert_select "table", count: 0
    assert_select "div", text: "¡No hay reservas!".to_s, count: 1
  end
end
