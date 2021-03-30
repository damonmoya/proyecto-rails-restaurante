require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        email: "Email"
      ),
      Book.create!(
        email: "Email"
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", text: "Email".to_s, count: 2
  end
end
