require 'rails_helper'

RSpec.describe 'routing to checkout', type: :routing do
  it "routes /orders/:order_id/checkout to checkout#show" do
    expect(get('/orders/:order_id/checkout')).to route_to(
      controller: 'checkouts',
      action: 'show',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/addresses to checkout#addresses" do
    expect(get('/orders/:order_id/checkout/addresses')).to route_to(
      controller: 'checkouts',
      action: 'addresses',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/update_addresses to checkout#update_addresses" do
    expect(patch('/orders/:order_id/checkout/update_addresses')).to route_to(
      controller: 'checkouts',
      action: 'update_addresses',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/delivery to checkout#delivery" do
    expect(get('/orders/:order_id/checkout/delivery')).to route_to(
      controller: 'checkouts',
      action: 'delivery',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/update_delivery to checkout#update_delivery" do
    expect(patch('/orders/:order_id/checkout/update_delivery')).to route_to(
      controller: 'checkouts',
      action: 'update_delivery',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/payment to checkout#payment" do
    expect(get('/orders/:order_id/checkout/payment')).to route_to(
      controller: 'checkouts',
      action: 'payment',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/update_payment to checkout#update_payment" do
    expect(patch('/orders/:order_id/checkout/update_payment')).to route_to(
      controller: 'checkouts',
      action: 'update_payment',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/confirm to checkout#confirm" do
    expect(get('/orders/:order_id/checkout/confirm')).to route_to(
      controller: 'checkouts',
      action: 'confirm',
      order_id: ':order_id'
    )
  end

  it "routes /orders/:order_id/checkout/place to checkout#place" do
    expect(post('/orders/:order_id/checkout/place')).to route_to(
      controller: 'checkouts',
      action: 'place',
      order_id: ':order_id'
    )
  end
end
