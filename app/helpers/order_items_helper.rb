module OrderItemsHelper
  def total_items_quantity
    session[:cart].map {|hash| hash.values}.flatten.map(&:to_i).reduce(:+)
  end

  def cart_count
    session[:cart].blank? ? "EMPTY" : total_items_quantity
  end
end
