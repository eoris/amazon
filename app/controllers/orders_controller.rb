class OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
  end

  def address
    @customer = current_customer
    @countries = Country.all
    @billing_address = Address.find_or_init_billing_address(@customer)
    @shipping_address = Address.find_or_init_shipping_address(@customer)
  end
end
