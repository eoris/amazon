class BillingAddress < Address
  belongs_to :order
  def self.build_billing_address(customer, current_order)
    billing_address = self.find_or_initialize_by(customer_id: customer.id).dup
    billing_address.order = current_order
    billing_address.customer = nil
    billing_address
  end
end
