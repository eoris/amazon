class Address < ActiveRecord::Base
  belongs_to :customer
  belongs_to :country
  belongs_to :order
  validates :firstname, :lastname,
            :address, :zipcode, :city, :phone,
            :country_id, presence: true

  def self.build_order_address(customer, current_order)
    order_address = self.find_or_initialize_by(customer_id: customer.id, type: self.name).dup
    order_address.order = current_order
    order_address.customer = nil
    order_address
  end
end
