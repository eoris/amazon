require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  before { setup_ability }
  let(:customer) { create(:customer) }
  let(:order)    { create(:order, state: 'in_progress', customer_id: customer.id) }
  let(:delivery) { create(:delivery) }

  it { is_expected.to use_before_action(:authenticate_customer!) }
  it { is_expected.to use_before_action(:set_customer) }
  it { is_expected.to use_before_action(:order_state_check) }
  it { is_expected.to use_before_action(:addresses_init) }
  it { is_expected.to use_before_action(:find_or_init_credit_card) }

  describe "GET #addresses" do
    context "when order has not in_progress state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
        get :addresses, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        get :addresses, order_id: order.id
      end

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
    context "when order has not in_progress state" do
      before do
        sign_in customer
        order = create(:order, state: 'in_delivery', customer_id: customer.id)
        patch :update_addresses, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        patch :update_addresses, order_id: order.id, billing_address: attributes_for(:address), shipping_address: attributes_for(:address)
      end

      it { is_expected.to redirect_to(delivery_order_checkout_path) }
      it { is_expected.to respond_with(302) }
    end

    context 'when addresses params is invalid' do
      before do
        sign_in customer
        patch :update_addresses, order_id: order.id, billing_address: attributes_for(:address, firstname: nil), shipping_address: attributes_for(:address)
      end

      it { is_expected.to render_template :addresses }
    end

    context 'when customer not signed in' do
      before { patch :update_addresses, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        patch :update_addresses, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "GET #delivery" do
    context "when order has not in_progress state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
        get :delivery, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when order has no billing or shipping addresses" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive_message_chain(:billing_address, :nil?).and_return(true)
        allow_any_instance_of(Order).to receive_message_chain(:shipping_address, :nil?).and_return(true)
        get :delivery, order_id: order.id
      end

      it { is_expected.to redirect_to(addresses_order_checkout_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive_message_chain(:billing_address, :nil?).and_return(false)
        allow_any_instance_of(Order).to receive_message_chain(:shipping_address, :nil?).and_return(false)
        get :delivery, order_id: order.id
      end

      it { is_expected.to render_template :delivery }
      it { is_expected.to respond_with(200) }
    end

    context 'when customer not signed in' do
      before { get :delivery, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        get :delivery, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "PATCH #update_delivery" do
    context "when order has not in_progress state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
        patch :update_delivery, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        patch :update_delivery, order_id: order.id, order: {delivery_id: delivery.id}
      end

      it { is_expected.to redirect_to(payment_order_checkout_path) }
      it { is_expected.to respond_with(302) }
    end

    context 'when customer not signed in' do
      before { patch :update_delivery, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        patch :update_delivery, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "GET #payment" do
    context "when order has not in_progress state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
        get :payment, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when order has no delivery" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive_message_chain(:delivery, :nil?).and_return(true)
        get :payment, order_id: order.id
      end

      it { is_expected.to redirect_to(delivery_order_checkout_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive_message_chain(:delivery, :nil?).and_return(false)
        get :payment, order_id: order.id
      end

      it { is_expected.to render_template :payment }
      it { is_expected.to respond_with(200) }
    end

    context 'when customer not signed in' do
      before { get :payment, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        get :payment, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "PATCH #update_payment" do
    context "when order has not in_progress state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
        patch :update_payment, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        patch :update_payment, order_id: order.id, credit_card: attributes_for(:credit_card)
      end

      it { is_expected.to redirect_to(confirm_order_checkout_path) }
      it { is_expected.to respond_with(302) }
    end

    context 'when payment params is invalid' do
      before do
        sign_in customer
        patch :update_payment, order_id: order.id, credit_card: attributes_for(:credit_card, cvv: nil)
      end

      it { is_expected.to render_template :payment }
    end

    context 'when customer not signed in' do
      before { patch :update_payment, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        patch :update_payment, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "GET #confirm" do
    context "when order has not in_progress state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
        get :confirm, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when order has no credit card" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive_message_chain(:credit_card, :nil?).and_return(true)
        get :confirm, order_id: order.id
      end

      it { is_expected.to redirect_to(payment_order_checkout_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive_message_chain(:credit_card, :nil?).and_return(false)
        get :confirm, order_id: order.id
      end

      it { is_expected.to render_template :confirm }
      it { is_expected.to respond_with(200) }
    end

    context 'when customer not signed in' do
      before { get :confirm, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        get :confirm, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "POST #place" do
    context "when order has not in_progress state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
        post :place, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context "when customer signed in" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:place!).and_return(true)
        post :place, order_id: order.id
      end

      it { is_expected.to redirect_to(order_checkout_path) }
      it { is_expected.to respond_with(302) }
    end

    context "when order not saved" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:place!).and_return(false)
        post :place, order_id: order.id
      end

      it { is_expected.to render_template(:confirm) }
    end

    context 'when customer not signed in' do
      before { post :place, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        post :place, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end

  describe "GET #show" do
    context "when order has not in_queue state" do
      before do
        sign_in customer
        allow_any_instance_of(Order).to receive(:in_queue?).and_return(false)
        get :show, order_id: order.id
      end

      it { is_expected.to redirect_to(confirm_order_checkout_path) }
    end

    context 'when customer not signed in' do
      before { get :show, order_id: order.id }
      it { is_expected.to redirect_to(new_customer_session_path) }
    end

    context 'when customer not authorized' do
      before do
        sign_in customer
        @ability.cannot :read, Order
        get :show, order_id: order.id
      end

      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash.to('You are not authorized to access this page.') }
    end
  end
end
