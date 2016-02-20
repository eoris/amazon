class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true

  def subtotal_price
    quantity * book.price
  end

  def self.create_order_items_from_cart(cart)
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

end
