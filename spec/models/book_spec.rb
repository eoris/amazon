require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:book) { FactoryGirl.create :book }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity_in_stock) }

  it { is_expected.to have_and_belong_to_many(:authors) }
  it { is_expected.to have_many(:ratings) }
  it { is_expected.to belong_to(:category) }

end
