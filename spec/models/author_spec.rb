require 'rails_helper'

RSpec.describe Author, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:author) { FactoryGirl.create :author }

  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }

  # it { expect(author).to have_many(:books) }
end
