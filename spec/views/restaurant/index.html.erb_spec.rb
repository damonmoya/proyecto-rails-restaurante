require 'rails_helper'

RSpec.describe "restaurant/index.html.erb", type: :view do
  it 'displays index page' do
    render
    expect(rendered).to have_content 'Mi restaurante'
  end
end
