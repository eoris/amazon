class CartsController < ApplicationController

  def index
    @cart = cart.summarized_merge
    @subtotal = cart.subtotal(@cart)
  end

  def add_item
    cart.add_item_to_cart(cart_params)
    redirect_to :back
  end

  def remove_item
    cart.remove_item_from_cart(params[:item_id])
    redirect_to :back
  end

  def clear
    session[:cart] = nil
    redirect_to :back
  end

  private

    def cart
      Cart.new(session[:cart] ||= [])
    end

    def cart_params
      params.require(:book).permit(:book_id, :quantity)
    end

end
