class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer

  def index
    @orders = @customer.orders
  end

  private

  def set_customer
    @customer = current_customer
  end

end
