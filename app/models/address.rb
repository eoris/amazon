class Address < ActiveRecord::Base
  belongs_to :customer
  belongs_to :country
  validates :firstname, :lastname,
            :address, :zipcode, :city, :phone,
            :customer_id, :country_id, presence: true

  def self.find_or_init_billing_address(customer)
    BillingAddress.find_or_initialize_by(customer_id: customer.id)
  end

  def self.find_or_init_shipping_address(customer)
    ShippingAddress.find_or_initialize_by(customer_id: customer.id)
  end

  def self.build_billing(customer, order, params)
    billing  = customer.addresses.build(params)
    billing.type = 'BillingAddress'
    billing.order_id = order.id
    billing
  end

  def self.build_shipping(customer, order, params)
    shipping  = customer.addresses.build(params)
    shipping.type = 'BillingAddress'
    shipping.order_id = order.id
    shipping
  end
end
