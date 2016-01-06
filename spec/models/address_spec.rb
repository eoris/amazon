require 'rails_helper'

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:address) { FactoryGirl.create :address }

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:country) }

end
