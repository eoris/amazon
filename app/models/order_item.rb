class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true

  def subtotal_price
    quantity * book.price
  end

  def self.summarized_merge(cart)
    hash = Hash.new(0)
      cart.each do |cart_hash|
        cart_hash.each do |key, value|
          hash[key] += value.to_i
        end
      end
    hash
  end
end
