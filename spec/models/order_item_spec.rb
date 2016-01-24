require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  it { is_expected.to have_db_column(:price) }
  it { is_expected.to have_db_column(:quantity) }
  it { is_expected.to have_db_column(:book_id) }
  it { is_expected.to have_db_column(:order_id) }

  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity) }

  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:order) }

end
