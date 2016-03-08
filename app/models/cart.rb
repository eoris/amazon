class Cart
  attr_accessor :session

  def initialize(session)
    @session = session
  end

  def remove_item_from_cart(item_id)
    @session.delete(item_id)
  end

  def params_valid?(params)
    params[:book_id].to_i.between?(1, Book.last.id) && params[:quantity].to_i.between?(1, 9)
  end

  def add_item_to_cart(cart_params)
    if params_valid?(cart_params)
      if @session.key?(cart_params[:book_id])
        @session[cart_params[:book_id]] += cart_params[:quantity].to_i
      else
        @session[cart_params[:book_id]] = cart_params[:quantity].to_i
      end
    end
  end

  def build_order_items_from_cart
    return if @session.empty?
    order_items = []
    @session.each_pair do |k, v|
      order_items << OrderItem.new(book_id: k,
                                   price: Book.find(k).price * v,
                                   quantity: v)
    end
    order_items
  end

  def build_order(customer)
    return if @session.empty?
    order_items = build_order_items_from_cart
    order = customer.orders.new(total_price: subtotal, completed_date: Time.now)
    order.order_items << order_items
    order
  end

  def subtotal
    @subtotal = 0
    @session.each_pair do |key, value|
      @subtotal += Book.find(key).price * value
    end
    @subtotal
  end
end
