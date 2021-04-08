require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      email: "email1@hotmail.com",
      start_time: "2021-04-22 14:32:00 UTC",
      diners: 1,
      is_confirmed: false
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input[name=?]", "book[email]"
      assert_select "select", 5
      assert_select "input[name=?]", "book[diners]"
      assert_select "input[name=?]", "book[is_confirmed]"
    end
  end
end
