class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  load_and_authorize_resource

  def index
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

end
