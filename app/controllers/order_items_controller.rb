class OrderItemsController < ApplicationController
  def index
    @cart = cart
  end

  def new

  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.price = @order_item.subtotal_price
    cart << order_item_params
    redirect_to :back
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end

    def cart
     session[:cart] ||= []
    end
end
