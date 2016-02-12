class OrderItemsController < ApplicationController
  def index
    @cart = OrderItem.summarized_merge(cart)
    byebug
  end

  def create
    cart << {params[:order_item][:book_id] => params[:order_item][:quantity]}
    redirect_to :back
  end

  def remove_item
    cart.delete_if {|item| item.keys.include?(params[:item_id])}
    redirect_to :back
  end

  def clear
    session[:cart] = nil
    redirect_to :back
  end

  private

    def cart
     session[:cart] ||= []
    end

end
