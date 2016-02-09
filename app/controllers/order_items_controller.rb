class OrderItemsController < ApplicationController
  def index
    @cart = cart
  end

  def create
    cart << order_item_params
    redirect_to :back
  end

  def clear
    session[:cart] = nil
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
