require 'rails_helper'

RSpec.describe "delivery", type: :feature do

  let(:customer)   { create(:customer) }
  let(:order)      { create(:order, state: 'in_progress', customer: customer,
                            billing_address: create(:billing_address),
                            shipping_address: create(:shipping_address)) }

  context 'customer not signed in' do
    scenario 'checkout delivery' do
      visit delivery_order_checkout_path(order)
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'customer signed in' do
    before do
      @deliveries = create_list(:delivery, 3)
    end

    scenario 'checkout delivery' do
      login_as(customer, scope: :customer)
      visit delivery_order_checkout_path(order)
      expect(page).to have_link I18n.t('checkout.address')
      expect(page).to have_link I18n.t('checkout.delivery')
      expect(page).to have_content I18n.t('checkout.delivery')
      expect(page).to have_content I18n.t('checkout.shipping')
      choose "order_delivery_id_#{@deliveries.last.id}"
      expect(find("#order_delivery_id_#{@deliveries.last.id}")).to be_checked
      click_button I18n.t('checkout.save')
      expect(page).to have_content I18n.t('checkout.payment')
    end
  end
end
