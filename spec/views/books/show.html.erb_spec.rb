require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      email: "prueba1@gmail.com",
      start_time: "2021-04-22 14:32:00 UTC"

    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/prueba1@gmail.com/)
    expect(rendered).to match(/2021-04-22 14:32:00 UTC/)
  end
end
