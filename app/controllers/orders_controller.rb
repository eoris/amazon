class OrdersController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_customer!
  before_action :customer_init

  steps :addresses, :delivery, :payment, :overview

  def index
    @orders = @customer.orders
  end

  def create
    @order_items = OrderItem.create_order_items_from_cart(session[:cart])
    @order = @customer.orders.build
    @order.total_price = Order.total_price_(@order_items)
    @order.completed_date = Time.now
    @order.save
    @order.order_items << @order_items
  end

  def show
    case step
    when :addresses
      @countries = Country.all
      @billing_address = Address.find_or_init_billing_address(@customer)
      @shipping_address = Address.find_or_init_shipping_address(@customer)
    end
    render_wizard
  end

  def update
    case step
    when :addresses
      @billing_address = BillingAddress.find_or_create_by(customer_id: current_customer.id)
      @billing_address.update(address_params)
      @shipping_address = ShippingAddress.find_or_create_by(customer_id: current_customer.id)
      @shipping_address.update(address_params)
    end
    render_wizard
  end

  private

    def customer_init
      @customer = current_customer
    end

    def address_params
      params.require(:address).permit(:firstname, :lastname, :address,
                                      :city, :country_id, :country,
                                      :zipcode, :phone)
    end

end
