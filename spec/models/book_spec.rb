require 'rails_helper'

RSpec.describe Book, type: :model do

  it { is_expected.to have_db_column(:title) }
  it { is_expected.to have_db_column(:description) }
  it { is_expected.to have_db_column(:price) }
  it { is_expected.to have_db_column(:quantity_in_stock) }
  it { is_expected.to have_db_column(:category_id) }

  it { is_expected.to have_and_belong_to_many(:authors) }
  it { is_expected.to have_many(:ratings) }
  it { is_expected.to belong_to(:category) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity_in_stock) }

  it do
    is_expected.to validate_numericality_of(:quantity_in_stock).
      is_greater_than_or_equal_to(0)
  end

end
