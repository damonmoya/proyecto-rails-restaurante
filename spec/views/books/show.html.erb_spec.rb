require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      email: "email1@hotmail.com",
      start_time: "2021-04-22 14:32:00 UTC",
      people: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/email1@hotmail.com/)
    expect(rendered).to match(/2/)
  end
end
