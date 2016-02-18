class CartsController < ApplicationController

  def index
    @cart = OrderItem.summarized_merge(cart)
  end

  def add_item
    if OrderItem.params_valid?(cart_params)
      cart << {cart_params[:book_id] => cart_params[:quantity]}
      redirect_to :back
    else
      redirect_to :back
    end
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

    def cart_params
      params.require(:book).permit(:book_id, :quantity)
    end

end
