require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:book) { create(:book) }
  let(:order) { create(:order) }
  let(:customer) { create(:customer) }
  let(:cart) { Cart.new({'1' => '1'}) }

  context "GET #show" do
    before { get :show }

    it "assignes cart" do
      get :show
      expect(assigns(:cart)).not_to be_nil
    end

    it 'render :show template' do
      expect(response).to render_template(:show)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  context "PATCH #update" do
    before { patch :update }

    it 'redirect to cart path' do
      expect(response).to redirect_to(cart_path)
      expect(response).to have_http_status(:found)
    end
  end

  context "POST #add_item" do
    before { post :add_item, book: {book_id: book.id, quantity: 1} }

    it 'redirect to cart path' do
      expect(response).to redirect_to(cart_path)
      expect(response).to have_http_status(:found)
    end
  end

  context "DELETE #remove_item" do
    before { delete :remove_item }

    it 'redirect to cart path' do
      expect(response).to redirect_to(cart_path)
      expect(response).to have_http_status(:found)
    end
  end

  context "DELETE #clear" do
    before do
      session[:cart] = 1
      delete :clear
    end

    it 'redirect to cart path' do
      expect(session[:cart]).to be_nil
      expect(response).to redirect_to(cart_path)
      expect(response).to have_http_status(:found)
    end
  end

  context "POST #checkout" do
    context 'when customer not signed in' do
      it 'redirect to sign in page' do
        post :checkout
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when an order is saved' do
      before do
        sign_in customer
        allow(Cart).to receive(:new).and_return(cart)
        allow(cart).to receive(:build_order).and_return(order)
        post :checkout
      end

      it 'redirect to checkout' do
        expect(session[:cart]).to be_nil
        expect(session[:discount]).to be_nil
        expect(response).to redirect_to(addresses_order_checkout_path(order))
      end

      it 'assign order' do
        expect(assigns(:order)).not_to be_nil
      end
    end

    context 'when an order is not saved' do
      before do
        sign_in customer
        post :checkout
      end

      it 'redirect to cart path' do
        expect(response).to redirect_to(cart_path)
      end
    end
  end
end
