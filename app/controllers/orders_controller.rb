class OrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_customer
  before_action :addresses_init, only: [:addresses, :create_addresses]
  before_action :find_order, except: [:index, :create]

  def index
    @orders = @customer.orders
  end

  def create
    @order_items = OrderItem.create_order_items_from_cart(session[:cart])
    @order       = Order.create_order(@customer, @order_items)
    redirect_to order_addresses_path(@order)
  end

  def addresses
  end

  def create_addresses
    @billing  = @customer.addresses.order(params[:order_id]).build(billing_params)
    @billing.type = 'BillingAddress'
    @shipping = @customer.addresses.order(params[:order_id]).build(shipping_params)
    @shipping.type = 'ShippingAddress'
    if @billing.save && @shipping.save
      redirect_to order_delivery_path
    else
      render 'addresses'
    end
  end

  private

    def set_customer
      @customer = current_customer
    end

    def find_order
      @order = Order.find(params[:order_id])
    end

    def addresses_init
      @countries = Country.all
      @billing_address = Address.find_or_init_billing_address(@customer)
      @shipping_address = Address.find_or_init_shipping_address(@customer)
    end

    def billing_params
      params.require(:addresses).permit(billing_address: [:firstname, :lastname, :address, :city, :country_id, :country, :zipcode, :phone])
    end

    def shipping_params
      params.require(:addresses).permit(shipping_address:
                                              [:firstname, :lastname,
                                               :address, :city, :country_id,
                                               :country, :zipcode, :phone])
    end
end
