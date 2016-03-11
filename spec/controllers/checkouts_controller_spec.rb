require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  before { setup_ability }
  let(:customer) { create(:customer) }
  let(:order)    { create(:order, state: 'in_progress', customer_id: customer.id) }

  describe "GET #addresses" do
    context "when customer signed in" do
      before do
        sign_in customer
        get :addresses, order_id: order.id
      end

      it { is_expected.to use_before_action(:authenticate_customer!) }
      it { is_expected.to use_before_action(:set_customer) }
      it { is_expected.to use_before_action(:order_state_check) }
      it { is_expected.to use_before_action(:addresses_init) }

      it { is_expected.to render_template :addresses }
      it { is_expected.to respond_with(200) }
    end

    context 'when customer not signed in' do
      before { get :addresses, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        get :addresses, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "PATCH #update_addresses" do
    context "when customer signed in" do
      before do
        sign_in customer
        patch :update_addresses, order_id: order.id, billing_address: attributes_for(:address), shipping_address: attributes_for(:address)
      end

      it { is_expected.to use_before_action(:authenticate_customer!) }
      it { is_expected.to use_before_action(:set_customer) }
      it { is_expected.to use_before_action(:order_state_check) }
      it { is_expected.to use_before_action(:addresses_init) }

      it { is_expected.to redirect_to(delivery_order_checkout_path) }
      it { is_expected.to respond_with(302) }
    end

    context 'when customer not signed in' do
      before { get :update_addresses, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end
  end
end
