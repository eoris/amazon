require 'rails_helper'

RSpec.describe Order, type: :model do

  it { is_expected.to have_db_column(:total_price) }
  it { is_expected.to have_db_column(:completed_date) }
  it { is_expected.to have_db_column(:state) }
  it { is_expected.to have_db_column(:customer_id) }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_one(:credit_card) }
  it { is_expected.to have_one(:billing_address) }
  it { is_expected.to have_one(:shipping_address) }

  it { is_expected.to validate_presence_of(:total_price) }
  it { is_expected.to validate_presence_of(:completed_date) }
  it { is_expected.to validate_presence_of(:state) }

  describe 'aasm state' do
    before(:each) {@order = Order.new}

    it 'transitions from in_progress to in_queue' do
      expect(@order).to transition_from(:in_progress).to(:in_queue).on_event(:in_queue)
      expect(@order).not_to transition_from(:in_progress).to(:in_delivery).on_event(:in_queue)
    end

    it 'transitions from in_queue to in_delivery' do
      expect(@order).to transition_from(:in_queue).to(:in_delivery).on_event(:in_delivery)
      expect(@order).not_to transition_from(:in_queue).to(:delivered).on_event(:in_delivery)
    end

    it 'transitions from in_queue to canceled' do
      expect(@order).to transition_from(:in_queue).to(:canceled).on_event(:canceled)
      expect(@order).not_to transition_from(:in_queue).to(:delivered).on_event(:canceled)
    end

    it 'transitions from in_delivery to canceled' do
      expect(@order).to transition_from(:in_delivery).to(:canceled).on_event(:canceled)
      expect(@order).not_to transition_from(:in_delivery).to(:delivered).on_event(:canceled)
    end
  end

  context '.state_enum' do
    it 'return state, except in_progress' do
      order = create(:order)
      expect(order.state_enum).to match_array(['in_queue', 'in_delivery', 'delivered', 'canceled'])
    end
  end

  context '#build_state_date_price' do
    before(:each) do
      @delivery = create(:delivery, price: 7)
      @order = create(:order, total_price: 10, state: 'in_progress', delivery_id: @delivery.id)
    end

    it 'build order with state, date and price' do
      expect(Order.build_state_date_price(@order).state).to eq('in_queue')
    end

    it 'build order completed date' do
      expect(Order.build_state_date_price(@order).completed_date.strftime('%Y-%m-%d')).to eq(Time.now.strftime('%Y-%m-%d'))
    end

    it 'build order total price' do
      expect(Order.build_state_date_price(@order).total_price).to eq(17)
    end
  end
end
