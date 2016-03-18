require 'rails_helper'

RSpec.describe 'routing to cart', type: :routing do
  it "routes /cart to cart#show" do
    expect(get('/cart')).to route_to(
      controller: 'carts',
      action: 'show'
    )
  end

  it "routes /cart to cart#update" do
    expect(patch('/cart')).to route_to(
      controller: 'carts',
      action: 'update'
    )
    expect(put('/cart')).to route_to(
      controller: 'carts',
      action: 'update'
    )
  end

  it "routes /cart/add_item to cart#add_item" do
    expect(post('/cart/add_item')).to route_to(
      controller: 'carts',
      action: 'add_item'
    )
  end

  it "routes /cart/remove_item to cart#remove_item" do
    expect(delete('/cart/remove_item')).to route_to(
      controller: 'carts',
      action: 'remove_item'
    )
  end

  it "routes /cart/checkout to cart#checkout" do
    expect(post('/cart/checkout')).to route_to(
      controller: 'carts',
      action: 'checkout'
    )
  end

  it "routes /cart/clear to cart#clear" do
    expect(delete('/cart/clear')).to route_to(
      controller: 'carts',
      action: 'clear'
    )
  end
end
