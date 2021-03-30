require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        email: "email1@hotmail.com",
        start_time: "2021-04-22 14:32:00 UTC"
      ),
      Book.create!(
        email: "email2@gmail.com",
        start_time: "2021-05-30 14:32:00 UTC"
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", text: "email1@hotmail.com".to_s
    assert_select "tr>td", text: "2021-04-22 14:32:00 UTC".to_s
    assert_select "tr>td", text: "email2@gmail.com".to_s
    assert_select "tr>td", text: "2021-05-30 14:32:00 UTC".to_s
  end
end
