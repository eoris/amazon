require 'rails_helper'

RSpec.describe 'routing to ratings', type: :routing do
  it "routes /books/:book_id/ratings/new to ratings#new" do
    expect(get('/books/:book_id/ratings/new')).to route_to(
      controller: 'ratings',
      action: 'new',
      book_id: ':book_id'
    )
  end

  it "routes /books/:book_id/ratings to ratings#create" do
    expect(post('/books/:book_id/ratings')).to route_to(
      controller: 'ratings',
      action: 'create',
      book_id: ':book_id'
    )
  end
end
