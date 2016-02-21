class Cart

  attr_accessor :session

  def initialize(session)
    @session = session
  end

  def remove_item_from_cart(item_id)
    @session.delete(item_id)
  end

  def params_valid?(params)
    params.values.all? { |v| v.to_i >= 1 }
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

  def subtotal
    @subtotal = 0
    @session.each_pair do |key, value|
      @subtotal += Book.find_by_id(key).price * value
    end
    @subtotal
  end
end
