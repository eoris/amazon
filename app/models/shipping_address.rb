class ShippingAddress < Address
  belongs_to :order
  def self.build_shipping_address(customer, current_order)
    shipping_address = self.find_or_initialize_by(customer_id: customer.id).dup
    shipping_address.order = current_order
    shipping_address.customer = nil
    shipping_address
  end
end
