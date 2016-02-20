class Cart

  attr_accessor :session

  def initialize(session)
    @session = session
  end

  def remove_item_from_cart(item_id)
    @session.delete_if {|item| item.keys.include?(item_id)}
  end

  def params_valid?(params)
    params.values.all? { |v| v.to_i >= 1 }
  end

  def add_item_to_cart(cart_params)
    if params_valid?(cart_params)
      @session << {cart_params[:book_id] => cart_params[:quantity]}
    end
  end

  def summarized_merge
    hash = Hash.new(0)
      @session.each do |cart_hash|
        cart_hash.each do |key, value|
          hash[key] += value.to_i
        end
      end
    hash
  end

  def subtotal(cart_hash)
    cart_hash.map do |key, value|
      Book.find_by(id: key).price * value
    end.reduce(:+)
  end
end
