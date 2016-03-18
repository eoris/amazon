require 'rails_helper'

RSpec.describe 'routing to orders', type: :routing do
  it "routes /orders to orders#index" do
    expect(get('/orders')).to route_to(
      controller: 'orders',
      action: 'index'
    )
  end

  it "routes /orders/:id to orders#show" do
    expect(get('/orders/:id')).to route_to(
      controller: 'orders',
      action: 'show',
      id: ':id'
    )
  end
end
