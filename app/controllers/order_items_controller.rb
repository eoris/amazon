class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all
  end

  def new

  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.save
    redirect_to :back
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end
end
