require 'rails_helper'

RSpec.describe 'routing to books', type: :routing do
  it "routes /books to books#index" do
    expect(get('/books')).to route_to(
      controller: 'books',
      action: 'index'
    )
  end

  it "routes /books/:id to books#show" do
    expect(get('/books/:id')).to route_to(
      controller: 'books',
      action: 'show',
      id: ':id'
    )
  end

  it "routes / books#bestsellers" do
    expect(get('/')).to route_to(
      controller: 'books',
      action: 'bestsellers'
    )
  end
end
