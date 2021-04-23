require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      email: "email1@hotmail.com",
      start_time: "2021-04-22 14:32:00 UTC",
      diners: 2,
      state: 0
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email:/)
    expect(rendered).to match(/email1@hotmail.com/)
    expect(rendered).to match(/Fecha y hora:/)
    expect(rendered).to match(/2021-04-22 14:32:00 UTC/)
    expect(rendered).to match(/Comensales:/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Estado de la reserva:/)
    expect(rendered).to match(/Pendiente/)
    expect(rendered).to match(/Cargo en la reserva:/)
    expect(rendered).to match(/Sin cargo/)    
  end
end
