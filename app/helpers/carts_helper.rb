module CartsHelper
  def order_item_book(book_id)
    Book.find_by(id: book_id.to_i)
  end

  def order_item_price(qty, book_id)
    qty * order_item_book(book_id).price
  end

  def total_items_quantity
    session[:cart].map {|hash| hash.values}.flatten.map(&:to_i).reduce(:+)
  end

  def cart_count
    session[:cart].blank? ? "EMPTY" : total_items_quantity
  end
end
