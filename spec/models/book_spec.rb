require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:book) { FactoryGirl.create :book }

  it {expect(book).to validate_presence_of(:title)}
  it {expect(book).to validate_presence_of(:price)}
  it {expect(book).to validate_presence_of(:quantity_in_stock)}


  it 'belongs to author' do
    expect(book).to respond_to :author
  end

  it 'belongs to category' do
    expect(book).to respond_to :category
  end

  it 'has many ratings' do
    expect(book).to respond_to :ratings
  end

end
