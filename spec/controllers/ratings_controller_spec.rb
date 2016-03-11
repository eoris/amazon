require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  before { setup_ability }
  let(:customer) { create(:customer) }
  let(:book) { create(:book) }

  describe 'GET #new' do
    context 'when customer signed in' do
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

    context 'when customer already left a review' do
      before do
        sign_in customer
        ratings = double(:ratings)
        rating = double(:rating)
        allow_any_instance_of(Book).to receive(:ratings).and_return(ratings)
        allow(ratings).to receive(:find_by).and_return(true)
        allow(ratings).to receive(:new).and_return(rating)
        allow(rating).to receive(:customer_id).with(customer.id)
        get :new, book_id: book.id
      end

      it 'redirect to book path' do
        expect(response).to redirect_to(book_path(book.id))
      end

      it 'flash notice' do
        expect(flash[:error]).to eq('You have already left a review')
      end
    end

    context 'when customer not signed in' do
      it 'redirect to sign_in page' do
        get :new, book_id: book.id
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when customer not authorized' do
      before do
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
    context 'when customer not signed in' do
      it 'redirect to sign_in page' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when customer signed in' do
      before { sign_in customer }

      it 'redirect to book path if params is valid' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(response).to redirect_to(book_path(book.id))
      end

      it 'sends success notice' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(flash[:notice]).to eq('Thank you for your review')
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
        sign_in customer
        @ability.cannot :create, Rating
        post :create, book_id: book.id, rating: attributes_for(:rating)
      end

      it { is_expected.to redirect_to(root_path) }
    end
  end
end
