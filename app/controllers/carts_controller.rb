class CartsController < ApplicationController
  before_action :authenticate_customer!

  def show
    @cart = cart.session
    @subtotal = cart.subtotal
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

  def checkout
    @order = cart.build_order(current_customer)
    if !cart.session.empty? && @order.save
      session[:cart] = nil
      redirect_to order_addresses_path(@order)
    else
      redirect_to :back
    end
  end

  private

    def cart
      Cart.new(session[:cart] ||= {})
    end

    def cart_params
      params.require(:book).permit(:book_id, :quantity)
    end
end
