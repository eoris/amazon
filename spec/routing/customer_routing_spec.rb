require 'rails_helper'

RSpec.describe 'routing to customer', type: :routing do
  it "routes /customer/edit to ratings#edit" do
    expect(get('/customer/edit')).to route_to(
      controller: 'customers',
      action: 'edit'
    )
  end

  it "routes /customer to ratings#update" do
    expect(patch('/customer')).to route_to(
      controller: 'customers',
      action: 'update'
    )
    expect(put('/customer')).to route_to(
      controller: 'customers',
      action: 'update'
    )
  end

  it "routes /customer/update_addresses to ratings#update_addresses" do
    expect(patch('/customer/update_addresses')).to route_to(
      controller: 'customers',
      action: 'update_addresses'
    )
  end
end
