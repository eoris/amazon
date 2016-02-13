class CartsController < ApplicationController

  def index
    @cart = OrderItem.summarized_merge(cart)
  end

  def add_item
    cart << {params[:book][:book_id] => params[:book][:quantity]}
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
