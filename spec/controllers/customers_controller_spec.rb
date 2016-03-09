require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:customer) { create(:customer) }

  describe 'GET #edit' do
    context 'when customer signed in' do
      it 'render :edit template' do
        sign_in customer
        get :edit, id: customer.id
        expect(response).to render_template(:edit)
      end
    end

    context 'when customer not signed in' do
      it 'redirect to sign in page' do
        get :edit, id: customer.id
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    context 'when customer not authorized' do
      before do
        setup_ability
        sign_in customer
        @ability.cannot :edit, Customer
        get :edit, id: customer.id
      end

      it 'redirect to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with customer params' do
      context 'when customer signed in' do
        before do
          sign_in customer
          patch :update, customer: attributes_for(:customer)
        end

        it 'redirect to edit customer' do
          expect(response).to redirect_to(edit_customer_path)
        end

        it 'flash notice' do
          expect(flash[:notice]).to eq('Your personal data updated')
        end

        it 'render :edit template when invalid params' do
          patch :update, customer: {firstname: '', lastname: '', email: ''}
          expect(response).to render_template(:edit)
        end
      end

      context 'when customer not signed in' do
        it 'redirect to sign in page' do
          patch :update, customer: attributes_for(:customer)
          expect(response).to redirect_to(new_customer_session_path)
        end
      end

      context 'when customer not authorized' do
        before do
          setup_ability
          sign_in customer
          @ability.cannot :update, Customer
          patch :update, customer: attributes_for(:customer)
        end

        it 'redirect to root path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'with passwords params' do
      context 'when customer signed in' do
        before do
          sign_in customer
          patch :update, passwords: { password: '12345678', current_password: customer.password, password_confirmation: '12345678'}
        end

        it 'redirect to edit customer' do
          expect(response).to redirect_to(edit_customer_path)
        end

        it 'flash notice' do
          expect(flash[:notice]).to eq('Password Changed')
        end

        it 'render :edit template when invalid params' do
          patch :update, passwords: { password: '', current_password: '', password_confirmation: ''}
          expect(response).to render_template(:edit)
        end
      end

      context 'when customer not signed in' do
        it 'redirect to sign in page' do
          patch :update, passwords: { password: '12345678', current_password: customer.password, password_confirmation: '12345678'}
          expect(response).to redirect_to(new_customer_session_path)
        end
      end

      context 'when customer not authorized' do
        before do
          setup_ability
          sign_in customer
          @ability.cannot :update, Customer
          patch :update, passwords: { password: '12345678', current_password: customer.password, password_confirmation: '12345678'}
        end

        it 'redirect to root path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'PATCH #update_addresses' do
    context 'with billing params' do
      context 'when customer signed in' do
        before do
          sign_in customer
          patch :update_addresses, billing_address: attributes_for(:address)
        end

        it 'with valid billing params redirect to edit customer' do
          expect(response).to redirect_to(edit_customer_path)
        end

        it 'with valid billing params flash notice' do
          expect(flash[:notice]).to eq('Billing address is updated')
        end

        it 'render :edit template when invalid params' do
          patch :update_addresses, billing_address: attributes_for(:address, firstname: '')
          expect(response).to render_template(:edit)
        end
      end

      context 'when customer not signed in' do
        it 'redirect to sign_in page' do
          patch :update_addresses, billing_address: attributes_for(:address)
          expect(response).to redirect_to(new_customer_session_path)
        end
      end

      context 'when customer not authorized' do
        before do
          setup_ability
          sign_in customer
          @ability.cannot :update_addresses, Customer
          patch :update_addresses, billing_address: attributes_for(:address)
        end

        it 'redirect to root path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'with shipping params' do
      context 'when customer signed in' do
        before do
          sign_in customer
          patch :update_addresses, shipping_address: attributes_for(:address)
        end

        it 'with valid shipping params redirect to edit customer' do
          expect(response).to redirect_to(edit_customer_path)
        end

        it 'with valid shipping params flash notice' do
          expect(flash[:notice]).to eq('Shipping address is updated')
        end

        it 'render :edit template when invalid params' do
          patch :update_addresses, shipping_address: attributes_for(:address, firstname: '')
          expect(response).to render_template(:edit)
        end
      end

      context 'when customer not signed in' do
        it 'redirect to sign_in page' do
          patch :update_addresses, shipping_address: attributes_for(:address)
          expect(response).to redirect_to(new_customer_session_path)
        end
      end

      context 'when customer not authorized' do
        before do
          setup_ability
          sign_in customer
          @ability.cannot :update_addresses, Customer
          patch :update_addresses, shipping_address: attributes_for(:address)
        end

        it 'redirect to root path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
