class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items
  has_one :billing_address
  has_one :shipping_address

  validates :total_price, :completed_date, :state, presence: true

  def self.total_price_(order_items)
    order_items.map { |oi| oi.price }.reduce(:+)
  end

  def self.create_order(customer, order_items)
    order = customer.orders.build
    order.total_price = Order.total_price_(order_items)
    order.completed_date = Time.now
    order.save
    order.order_items << order_items
    order
  end
end
