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

  describe '.build_order_address' do
    before(:each) do
      @customer = create(:customer)
      @order = create(:order)
      create(:address, customer: @customer, type: 'ShippingAddress')
      create(:address, customer: @customer, type: 'BillingAddress')
    end

    context 'when shipping address' do
      it 'address type ShippingAddress' do
        expect(ShippingAddress.build_order_address(@customer, @order).type).to eq('ShippingAddress')
      end

      it 'build shipping address' do
        expect(ShippingAddress.build_order_address(@customer, @order).firstname).to eq(@customer.shipping_address.firstname)
      end

      it 'assign order_id to shipping address' do
        expect(ShippingAddress.build_order_address(@customer, @order).order_id).to eq(@order.id)
      end

      it 'delete customer_id from shipping address' do
        expect(ShippingAddress.build_order_address(@customer, @order).customer_id).to be_nil
      end
    end

    context 'when billing address' do
      it 'address type BillingAddress' do
        expect(BillingAddress.build_order_address(@customer, @order).type).to eq('BillingAddress')
      end

      it 'build shipping address' do
        expect(BillingAddress.build_order_address(@customer, @order).firstname).to eq(@customer.billing_address.firstname)
      end

      it 'assign order_id to billing address' do
        expect(BillingAddress.build_order_address(@customer, @order).order_id).to eq(@order.id)
      end

      it 'delete customer_id from billing address' do
        expect(BillingAddress.build_order_address(@customer, @order).customer_id).to be_nil
      end
    end
  end
end
