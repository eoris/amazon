require 'rails_helper'

RSpec.describe "complete", type: :feature do

  let(:customer) { create(:customer) }
  let(:country)  { create(:country) }
  let(:order)    { create(:order, state: 'in_progress', customer: customer,
                          billing_address: create(:billing_address),
                          shipping_address: create(:shipping_address),
                          delivery: create(:delivery),
                          credit_card: create(:credit_card)) }

  context 'customer not signed in' do
    scenario 'checkout complete' do
      visit order_checkout_path(order)
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'customer signed in' do
    before do
      allow_any_instance_of(BillingAddress).to receive_message_chain(:country, :name).and_return(country)
      allow_any_instance_of(ShippingAddress).to receive_message_chain(:country, :name).and_return(country)
    end

    scenario 'checkout complete' do
      login_as(customer, scope: :customer)
      visit order_checkout_path(order)
      expect(page).to have_link I18n.t('checkout.address')
      expect(page).to have_link I18n.t('checkout.delivery')
      expect(page).to have_link I18n.t('checkout.payment')
      expect(page).to have_link I18n.t('checkout.confirm')
      expect(page).to have_content I18n.t('checkout.confirm')
      click_button I18n.t('checkout.place_order')
      expect(page).to have_content I18n.t('checkout.back_to_store')
    end
  end
end
