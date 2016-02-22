class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true

  def self.create_order_items_from_cart(cart)
    order_items = []
    cart.each_pair do |k, v|
      order_items << self.create(book_id: k,
                                  price: (Book.find_by_id(k).price) * v,
                                  quantity: v)
    end
    order_items
  end

  def self.subtotal(order_items)
    order_items.map {|i| i.price}.reduce(:+)
  end

end
