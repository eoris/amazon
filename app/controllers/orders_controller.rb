class OrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_customer
  before_action :addresses_init, only: [:addresses]
  before_action :find_order, except: [:index, :create]

  def index
    @orders = @customer.orders
  end

  def create
    @order_items = OrderItem.create_order_items_from_cart(session[:cart])
    @order       = Order.create_order(@customer, @order_items)
    session[:cart] = nil
    redirect_to order_addresses_path(@order)
  end

  def addresses
  end

  def create_addresses
    @billing_address  = Address.build_billing(@customer, @order,
                                      billing_params)
    @shipping_address = Address.build_shipping(@customer, @order,
                                      shipping_params)
    if @billing_address.save && @shipping_address.save
      redirect_to order_delivery_path
    else
      render 'addresses'
    end
  end

  def delivery
    @deliveries = Delivery.all.reverse
  end

  def create_delivery
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
      @billing_address = Address.find_or_init_billing_address(@customer)
      @shipping_address = Address.find_or_init_shipping_address(@customer)
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
