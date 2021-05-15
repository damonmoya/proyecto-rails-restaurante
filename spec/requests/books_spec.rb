 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/books", type: :request do
  
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:admin) { FactoryBot.create(:admin) }

  let(:valid_attributes) {
    {email: "prueba@gmail.com", start_time: "2021-05-30 14:32:00 UTC", diners: 2, state: "pending"}
  }

  let(:valid_check_attributes) {
    {email: "prueba@gmail.com", expire_time: (DateTime.now + (1.0/48))}
  }

  let(:valid_expired_check_attributes) {
    {email: "prueba@gmail.com", expire_time: (DateTime.now - 1)}
  }

  let(:random_token) {
    Digest::SHA1.hexdigest([Time.now, rand].join)
  }

  let(:valid_noshow_attributes) {
    {email: "prueba@gmail.com", start_time: "2021-05-30 14:32:00 UTC", diners: 2, state: "no_show"}
  }

  let(:valid_topay_attributes) {
    {email: "prueba@gmail.com", start_time: "2021-05-30 14:32:00 UTC", diners: 2, state: "to_pay"}
  }

  let(:invalid_attributes) {
    {email: nil, start_time: nil, diners: 0, state: "pending"}
  }

  describe "GET /index" do
    before :each do
      sign_in admin 
    end

    it "renders a successful response" do
      Book.create! valid_attributes
      get books_url
      expect(response).to be_successful
    end
    it "renders a successful response v2" do
      Book.create! valid_attributes
      get books_url, params: { search: "something" }
      expect(response).to be_successful
    end
  end

  describe "GET /mybooks" do
    it "renders a successful response" do
      check = Check.create! valid_check_attributes
      get mybooks_books_url, params: { token: check.token }
      expect(response).to be_successful
    end
    it "redirects to home (expired link)" do 
      check = Check.create! valid_expired_check_attributes
      get mybooks_books_url, params: { token: check.token }
      expect(response).to redirect_to(restaurant_index_path)
    end
    it "redirects to home (invalid token)" do
      get mybooks_books_url, params: { token: random_token }
      expect(response).to redirect_to(restaurant_index_path)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      book = Book.create! valid_attributes
      get book_url(book)
      expect(response).to be_successful
    end
    
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_book_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    before :each do
      sign_in admin 
    end
    
    it "render a successful response" do
      book = Book.create! valid_attributes
      get edit_book_url(book)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Book" do
        expect {
          post books_url, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it "redirects to the created book" do
        post books_url, params: { book: valid_attributes }
        expect(response).to redirect_to(book_url(Book.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book" do
        expect {
          post books_url, params: { book: invalid_attributes }
        }.to change(Book, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post books_url, params: { book: invalid_attributes }
        get new_book_url
        expect(response).to be_successful
      end
    end
  end

  describe "POST /create (no-show books present)" do

    it "no-show books present" do
      @book1 = Book.create! valid_noshow_attributes
      expect {
        post books_url, params: { book: valid_attributes }
      }.to change(Book, :count).by(0)
      post books_url, params: { book: valid_attributes }
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

  describe "GET /pay" do
    it "redirect to books" do
      get pay_books_url, params: { 
        diners: valid_attributes[:diners],
        start_time_1i: "2021", 
        start_time_2i: "05", 
        start_time_3i: "30", 
        start_time_4i: "14", 
        start_time_5i: "32" 
      }
      expect(response).to redirect_to(books_path)
    end
  end

  describe "POST /checkout" do

    it "creates new book" do
      book1 = Book.create! valid_topay_attributes
      expect {
        post checkout_books_url, params: { 
          email: valid_attributes[:email], 
          diners: valid_attributes[:diners],
          start_time_1i: "2021", 
          start_time_2i: "05", 
          start_time_3i: "30", 
          start_time_4i: "14", 
          start_time_5i: "32" 
        }
      }.to change(Book, :count).by(1)
      expect(ActionMailer::Base.deliveries.count).to eq(2)
      #expect(response).to be_successful
    end

    it "invalid captcha" do
      book1 = Book.create! valid_topay_attributes
      post checkout_books_url, params: { 
        email: valid_attributes[:email], 
        diners: valid_attributes[:diners],
        start_time_1i: "2021", 
        start_time_2i: "05", 
        start_time_3i: "30", 
        start_time_4i: "14", 
        start_time_5i: "32",
        "g-recaptcha-response": ""
      }
      expect(response).to redirect_to(pay_books_path(
        email: valid_attributes[:email], 
        diners: valid_attributes[:diners],
        start_time_1i: "2021", 
        start_time_2i: "05", 
        start_time_3i: "30", 
        start_time_4i: "14", 
        start_time_5i: "32",
        notice: "No se ha validado el Captcha"
      ))
      #expect(response).to be_successful
    end

  end

  describe "PATCH /update" do

    before :each do
      sign_in admin 
    end

    context "with valid parameters" do
      let(:new_attributes) {
        {email: "prueba2@gmail.com", start_time: "2021-07-30 14:32:00 UTC", diners: 2, state: "confirmed"}
      }

      it "updates the requested book" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(response).to redirect_to(book_url(book))
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it "redirects to the book" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(response).to redirect_to(book_url(book))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: invalid_attributes }
        get edit_book_url
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    before :each do
      sign_in admin 
    end
    
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete book_url(book)
      }.to change(Book, :count).by(-1)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it "redirects to the books list" do
      book = Book.create! valid_attributes
      delete book_url(book)
      expect(response).to redirect_to(books_url)
    end
  end
end
