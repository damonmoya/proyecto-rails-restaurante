require 'rails_helper'

RSpec.describe 'Mi restaurante', type: :feature do
  scenario 'index page' do
      visit root_path
      expect(page).to have_content('Mi restaurante')
  end
end
