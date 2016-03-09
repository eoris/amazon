require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:customer) { create(:customer) }
  let(:book) { create(:book) }

  describe 'GET #new' do
    context 'when customer sign in' do
      before do
        sign_in customer
        get :new, book_id: book.id
      end

      it 'render :new template' do
        expect(response).to render_template(:new)
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context 'when customer not sign in' do
      it 'redirect to sign_in page' do
        get :new, book_id: book.id
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when customer not authorized' do
      before do
        setup_ability
        sign_in customer
        @ability.cannot :new, Rating
      end

      it 'redirect to root path' do
        get :new, book_id: book.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when customer not sign in' do
      it 'redirect to sign_in page' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when customer sign in' do
      before { sign_in customer }

      it 'redirect to book path if params is valid' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(response).to redirect_to(book_path(book.id))
      end

      it 'render :new with invalid params' do
        post :create, book_id: book.id, rating: attributes_for(:rating, review: '')
        expect(response).to render_template(:new)
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context 'when customer not authorized' do
      before do
        setup_ability
        sign_in customer
        @ability.cannot :create, Rating
      end

      it 'redirect to root' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
