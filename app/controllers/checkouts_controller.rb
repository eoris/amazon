class CheckoutsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  before_action :find_order
  before_action :order_state_check, except: [:show]
  before_action :addresses_init, only: [:addresses, :create_addresses]
  before_action :find_or_init_credit_card, only: [:payment, :create_payment]

  def addresses
    redirect_to root_path if @order.nil?
  end

  def create_addresses
    if @billing_address.update(billing_params) && @shipping_address.update(shipping_params)
      redirect_to delivery_order_checkout_path
    else
      render 'addresses'
    end
  end

  def delivery
    redirect_to addresses_order_checkout_path if @order.billing_address.nil?
    @deliveries = Delivery.all
  end

  def create_delivery
    if @order.update(delivery_params)
      redirect_to payment_order_checkout_path
    else
      render 'delivery'
    end
  end

  def payment
    redirect_to delivery_order_checkout_path if @order.delivery.nil?
    @credit_card = CreditCard.find_or_initialize_by(order_id: @order.id)
  end

  def create_payment
    if @credit_card.update(payment_params)
      redirect_to confirm_order_checkout_path
    else
      render 'payment'
    end
  end

  def confirm
    redirect_to payment_order_checkout_path if @order.credit_card.nil?
  end

  def place
    @order.state = 'in queue'
    @order.completed_date = Time.now
    @order.total_price += @order.delivery.price
    if @order.save
      redirect_to order_checkout_path
    else
      render 'confirm'
    end
  end

  def show
    redirect_to confirm_order_checkout_path unless @order.state == 'in queue'
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

  def order_state_check
    redirect_to root_path unless @order.state == 'in progress'
  end

  def addresses_init
    @countries = Country.all
    if @order.billing_address.nil? && @order.shipping_address.nil?
      @billing_address = BillingAddress.find_or_initialize_by(customer_id: @customer.id)
      @billing_address.order_id = @order.id
      @billing_address.customer_id = nil
      @shipping_address = ShippingAddress.find_or_initialize_by(customer_id: @customer.id)
      @shipping_address.order_id = @order.id
      @shipping_address.customer_id = nil
    else
      @billing_address = BillingAddress.find_by(order_id: @order.id)
      @shipping_address = ShippingAddress.find_by(order_id: @order.id)
    end
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
