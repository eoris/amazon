require 'rails_helper'

RSpec.describe Rating, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:rating) { FactoryGirl.create :rating }

  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:customer) }

end
