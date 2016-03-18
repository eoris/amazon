require 'rails_helper'

RSpec.describe "addresses", type: :feature, js: true do

  let(:customer) { create(:customer) }
  let(:order) { create(:order, customer: customer, state: 'in_progress') }

  context 'customer not signed in' do
    scenario 'checkout addresses' do
      visit addresses_order_checkout_path(order)
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'customer signed in' do
    scenario 'checkout addresses' do
      country = create(:country)
      delivery = create_list(:delivery, 3)
      login_as(customer, scope: :customer)
      visit addresses_order_checkout_path(order)
      expect(page).to have_content(I18n.t('checkout.billing_address'))
      expect(page).to have_content(I18n.t('checkout.shipping_address'))
      within(".billing") do
        fill_in 'Firstname', with: Faker::Name.first_name
        fill_in 'Lastname', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        select country.name, from: 'billing_address[country_id]'
        fill_in 'Zipcode', with: Faker::Number.number(6)
        fill_in 'Phone', with: Faker::PhoneNumber.phone_number
      end
      check 'shipping-checkbox'
      click_button I18n.t('checkout.save')
      expect(page).to have_content I18n.t('checkout.delivery')
      expect(page).to have_content I18n.t('checkout.shipping')
    end
  end
end
