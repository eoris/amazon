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

  def self.create_order_items(cart)
    hash = self.summarized_merge(cart)
    order_items = hash.each_pair do |k, v|
      self.create(book_id: k,
                  price: (Book.find_by_id(k).price) * v,
                  quantity: v)
    end
  end

  def self.subtotal(order_items)
    order_items.map {|i| i.price}.reduce(:+)
  end

  def self.params_valid?(params)
    params.values.all? { |v| v.to_i >= 1 }
  end
end
