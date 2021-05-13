require 'rails_helper'

RSpec.describe "Restaurants", type: :request do

  let(:valid_attributes) {
    {email: "prueba@gmail.com", start_time: "2021-05-30 14:32:00 UTC", diners: 2, state: "pending"}
  }

  let(:invalid_attributes) {
    {email: nil, start_time: nil, diners: 0, state: "pending"}
  }

  let(:valid_noshow_attributes) {
    {email: "prueba@gmail.com", start_time: "2021-05-30 14:32:00 UTC", diners: 2, state: "no_show"}
  }

  describe "GET /index" do
    it "returns http success" do
      get "/restaurant/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /index" do
    context "with valid parameters" do
      it "creates a new Book" do
        expect {
          post restaurant_index_url, params: valid_attributes
        }.to change(Book, :count).by(1)
      end

      it "redirects to the created book" do
        post restaurant_index_url, params: valid_attributes
        expect(response).to redirect_to(book_url(Book.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book" do
        expect {
          post restaurant_index_url, params: invalid_attributes
        }.to change(Book, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'index' template)" do
        post restaurant_index_url, params: invalid_attributes
        get restaurant_index_url
        expect(response).to be_successful
      end
    end
  end

  describe "POST /index (no-show books present)" do

    it "no-show books present" do
      @book1 = Book.create! valid_noshow_attributes
      expect {
        post restaurant_index_url, params: valid_attributes
      }.to change(Book, :count).by(0)
      post restaurant_index_url, params: valid_attributes
      expect(response).to redirect_to(pay_books_path(
        email: valid_attributes[:email], 
        diners: valid_attributes[:diners],
        start_time_1i: valid_attributes["start_time(1i)"], 
        start_time_2i: valid_attributes["start_time(2i)"], 
        start_time_3i: valid_attributes["start_time(3i)"], 
        start_time_4i: valid_attributes["start_time(4i)"], 
        start_time_5i: valid_attributes["start_time(5i)"] 
      ))
      get pay_books_url, params: { 
        email: valid_attributes[:email], 
        diners: valid_attributes[:diners],
        start_time_1i: "2021", 
        start_time_2i: "05", 
        start_time_3i: "30", 
        start_time_4i: "14", 
        start_time_5i: "32" 
      }
      expect(response).to be_successful
    end

  end

  describe "POST /mybooks" do

    it "does not send email" do
      post restaurant_mybooks_url, params: { email: "prueba@gmail.com" }
      expect(response).to redirect_to(restaurant_index_path)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end

    it "sends email" do
      book = Book.create! valid_attributes
      post restaurant_mybooks_url, params: { email: book.email }
      expect(response).to redirect_to(restaurant_index_path)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

  end

end
