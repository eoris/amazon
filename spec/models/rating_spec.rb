require 'rails_helper'

RSpec.describe Rating, type: :model do

  it { is_expected.to have_db_column(:review) }
  it { is_expected.to have_db_column(:rating) }
  it { is_expected.to have_db_column(:customer_id) }
  it { is_expected.to have_db_column(:book_id) }

  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:customer) }

  it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(10) }
  it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(0) }


end
