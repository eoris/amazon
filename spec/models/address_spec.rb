require 'rails_helper'

RSpec.describe Address, type: :model do

  it { is_expected.to have_db_column(:firstname) }
  it { is_expected.to have_db_column(:lastname) }
  it { is_expected.to have_db_column(:address) }
  it { is_expected.to have_db_column(:zipcode) }
  it { is_expected.to have_db_column(:city) }
  it { is_expected.to have_db_column(:phone) }
  it { is_expected.to have_db_column(:customer_id) }
  it { is_expected.to have_db_column(:country_id) }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to belong_to(:country) }
  it { is_expected.to belong_to(:order) }

  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:zipcode) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:country_id) }

  describe '#build_order_address' do
    it 'build address for order' do
      customer = create(:customer)
      shipping = create(:address, customer: customer)
      order = create(:order)

      expect(Address.build_order_address(customer, order, 'ShippingAddress').firstname).to eq(customer.shipping_address.firstname)
      expect(Address.build_order_address(customer, order, 'ShippingAddress').order_id).to eq(order.id)
      expect(Address.build_order_address(customer, order, 'ShippingAddress').customer_id).to be_nil
      expect(Address.build_order_address(customer, order, 'ShippingAddress').type).to eq('ShippingAddress')
    end
  end
end
