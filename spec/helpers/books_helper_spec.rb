require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BooksHelper. For example:
#
# describe BooksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BooksHelper, type: :helper do
    before(:each) do 
        @book1 = Book.create!(email: "email1@hotmail.com", start_time: "2021-04-22 14:32:00 UTC", diners: 2, state: 0)
        @book2 = Book.create!(email: "email1@hotmail.com", start_time: "2021-04-22 14:32:00 UTC", diners: 2, state: 1)
        @book3 = Book.create!(email: "email1@hotmail.com", start_time: "2021-04-22 14:32:00 UTC", diners: 2, state: 2)
        @book4 = Book.create!(email: "email1@hotmail.com", start_time: "2021-04-22 14:32:00 UTC", diners: 2, state: 3, charge: Money.new(500, "EUR"))
    end 

    it "returns known states" do
        expect(helper.state_book(@book1)).to eq("Pendiente")
        expect(helper.state_book(@book2)).to eq("Confirmada")
        expect(helper.state_book(@book3)).to eq("No presentada")
        expect(helper.state_book(@book4)).to eq("A pagar")
    end

    it "returns charge" do
        expect(helper.charge_book(@book1)).to eq("Sin cargo")
        expect(helper.charge_book(@book2)).to eq("Sin cargo")
        expect(helper.charge_book(@book3)).to eq("Sin cargo")
        expect(helper.charge_book(@book4)).to eq("5.00€")
    end
end
