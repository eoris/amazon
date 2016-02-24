class OrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_customer
  before_action :find_order, except: [:index]
  before_action :addresses_init, only: [:addresses, :create_addresses]
  before_action :find_or_init_credit_card, only: [:payment, :create_payment]

  def index
    @orders = @customer.orders
  end

  def addresses
  end

  def create_addresses
    @billing_address.customer = @customer
    @shipping_address.customer = @customer
    if @billing_address.update(billing_params) && @shipping_address.update(shipping_params)
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
    @credit_card = CreditCard.find_or_initialize_by(order_id: @order.id)
  end

  def create_payment
    if @credit_card.update(payment_params)
      redirect_to order_confirm_path
    else
      render 'payment'
    end
  end

  private

    def set_customer
      @customer = current_customer
    end

    def find_order
      @order = Order.find(params[:order_id])
    end

    def find_or_init_credit_card
      @credit_card = CreditCard.find_or_initialize_by(order_id: @order.id)
    end

    def addresses_init
      @countries = Country.all
      @billing_address = BillingAddress.find_or_initialize_by(order_id: @order.id)
      @shipping_address = ShippingAddress.find_or_initialize_by(order_id: @order.id)
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

    def payment_params
      params.require(:credit_card).permit(:expiration_month, :number,
                                      :expiration_year, :cvv)
    end
end
