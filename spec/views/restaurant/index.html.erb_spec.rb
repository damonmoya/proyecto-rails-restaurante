require 'rails_helper'

RSpec.describe "restaurant/index.html.erb", type: :view do
  before(:each) do
    assign(:book, Book.new)
  end
  it 'displays index page' do
    render
    expect(rendered).to have_content 'Nueva reserva'
    assert_select "form[action=?][method=?]", restaurant_index_path, "post" do
      assert_select "input[name=?]", "email"
      assert_select "select", 5
      assert_select "input[name=?]", "diners"
    end
    expect(rendered).to have_content 'Consultar reservas'
    assert_select "form[action=?][method=?]", restaurant_mybooks_path, "post" do
      assert_select "input[name=?]", "email"
    end

  end
end
