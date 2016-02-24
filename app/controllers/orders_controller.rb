class OrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_customer
  before_action :addresses_init, only: [:addresses, :create_addresses]
  before_action :find_order, except: [:index, :create]

  def index
    @orders = @customer.orders
  end

  def addresses
  end

  def create_addresses
    @billing_address = @order.build_billing_address(billing_params)
    @billing_address.customer = @customer
    @shipping_address = @order.build_shipping_address(shipping_params)
    @shipping_address.customer = @customer
    if @billing_address.save && @shipping_address.save
      redirect_to order_delivery_path
    else
      render 'addresses'
    end
  end

  def delivery
    @deliveries = Delivery.all
  end

  def update_delivery
    if @customer.id == @order.customer_id
      @order.update(delivery_params)
      redirect_to order_payment_path
    else
      render 'delivery'
    end
  end

  def payment
    @credit_card = CreditCard.new
  end

  def create_payment

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
      @billing_address = BillingAddress.find_or_initialize_by(customer_id: @customer.id)
      @shipping_address = ShippingAddress.find_or_initialize_by(customer_id: @customer.id)
    end

    def billing_params
      params.require(:billing_address).permit(:firstname, :lastname,
                                               :address, :city, :country_id,
                                               :country, :zipcode, :phone)
    end

    def shipping_params
      params.require(:shipping_address).permit(:firstname, :lastname,
                                               :address, :city, :country_id,
                                               :country, :zipcode, :phone)
    end

    def delivery_params
      params.require(:order).permit(:delivery_id)
    end
end
