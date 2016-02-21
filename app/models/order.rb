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
end
