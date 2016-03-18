require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  before         { setup_ability }
  let(:order)    { create(:order) }
  let(:customer) { create(:customer) }

  context "GET #index" do
    context "when customer signed in" do
      before do
        sign_in(customer)
        get :index
      end

      it 'render :index template' do
        expect(response).to render_template(:index)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when customer not signed in" do
      it "redirect to sign_in page" do
        get :index
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when customer not authorized' do
      before do
        sign_in(customer)
        @ability.cannot :read, Order
      end

      it 'redirect to root path' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'GET #show' do
    context "when customer signed in" do
      before do
        sign_in(customer)
        get :show, id: order.id
      end

      it 'render show template' do
        expect(response).to render_template(:show)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when customer not signed in" do
      it "redirect to sign_in page" do
        get :show, id: order.id
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when customer not authorized' do
      before do
        sign_in(customer)
        @ability.cannot :read, Order
      end

      it 'redirect to root path' do
        get :show, id: order.id
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
