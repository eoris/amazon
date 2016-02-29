class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer

  def index
    @orders = @customer.orders
  end

  def show
    begin
      @order = @customer.orders.find(params[:id])
    rescue
      redirect_to orders_path
    end
  end

  private

  def set_customer
    @customer = current_customer
  end

end
