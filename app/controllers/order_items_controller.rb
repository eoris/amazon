class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all
  end

  def new

  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.price = @order_item.subtotal_price(order_item_book)
    session[:order_item] = @order_item
    redirect_to :back
  end

  private

    def order_item_book
      @book = @order_item.book
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end
end
