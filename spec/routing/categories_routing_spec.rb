require 'rails_helper'

RSpec.describe 'routing to categories', type: :routing do
  it "routes /categories to categories#index" do
    expect(get('/categories')).to route_to(
      controller: 'categories',
      action: 'index'
    )
  end

  it "routes /categories/:id to categories#show" do
    expect(get('/categories/:id')).to route_to(
      controller: 'categories',
      action: 'show',
      id: ':id'
    )
  end
end
