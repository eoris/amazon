class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true

  def subtotal_price(item)
    quantity * item.price
  end
end
