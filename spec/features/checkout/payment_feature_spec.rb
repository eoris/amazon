require 'rails_helper'

RSpec.describe "payment", type: :feature do

  let(:customer) { create(:customer) }
  let(:country)  { create(:country) }
  let(:order)    { create(:order, state: 'in_progress', customer: customer,
                          billing_address: create(:billing_address),
                          shipping_address: create(:shipping_address),
                          delivery: create(:delivery)) }

  context 'customer not signed in' do
    scenario 'checkout payment' do
      visit payment_order_checkout_path(order)
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'customer signed in' do
    before do
      allow_any_instance_of(BillingAddress).to receive_message_chain(:country, :name).and_return(country)
      allow_any_instance_of(ShippingAddress).to receive_message_chain(:country, :name).and_return(country)
    end

    scenario 'checkout payment' do
      login_as(customer, scope: :customer)
      visit payment_order_checkout_path(order)
      expect(page).to have_link I18n.t('checkout.address')
      expect(page).to have_link I18n.t('checkout.delivery')
      expect(page).to have_link I18n.t('checkout.payment')
      expect(page).to have_content I18n.t('checkout.payment')
      within('.new_credit_card') do
        fill_in 'credit_card[number]', with: Faker::Number.number(16)
        select '1', from: 'credit_card[expiration_month]'
        select '2033', from: 'credit_card[expiration_year]'
        fill_in 'credit_card[cvv]', with: Faker::Number.number(3)
      end
      click_button I18n.t('checkout.save')
      expect(page).to have_content I18n.t('checkout.confirm')
      expect(page).to have_link I18n.t('checkout.confirm')
    end
  end
end
