class OrderItemsController < ApplicationController
  def index
    @cart = summarized_merge(cart)
  end

  def create
    cart << {order_item_params[:book_id] => order_item_params[:quantity]}
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

    def summarized_merge(cart)
      hash = Hash.new(0)
        cart.each do |cart_hash|
          cart_hash.each do |key, value|
            hash[key] += value.to_i
          end
        end
      hash
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :book_id)
    end

    def cart
     session[:cart] ||= []
    end
end
