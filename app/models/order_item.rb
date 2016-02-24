class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true

  def create_order_items_from_cart(cart)
    if cart.nil?
      return
    else
      order_items = []
        cart.each_pair do |k, v|
          order_item = OrderItem.new
          order_items << order_item.create(book_id: k,
                                           price: (Book.find(k).price) * v,
                                           quantity: v)
        end
      order_items
    end
  end

  def subtotal(arr)
    arr.map(&:price).reduce(:+)
  end

end
