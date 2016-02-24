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

end
