require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      email: "email1@hotmail.com",
      start_time: "2021-04-22 14:32:00 UTC",
      diners: 2,
      state: 0
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input[name=?]", "book[email]"
      assert_select "select", 5
      assert_select "input[name=?]", "book[diners]"
    end
  end
end
