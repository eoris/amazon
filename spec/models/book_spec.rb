require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:book) { FactoryGirl.create :book }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quantity_in_stock }


  # it 'belongs to author' do
  #   expect(book).to respond_to(:author)
  # end

  # it 'belongs to category' do
  #   expect(book).to respond_to(:category)
  # end

  # it 'has many ratings' do
  #   expect(book).to respond_to(:ratings)
  # end

  it { should belong_to :author }
  it { should belong_to :category }
  it { should have_many :ratings }

end
