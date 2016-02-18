class OrdersController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_customer!

  steps :address, :delivery, :payment, :overview

  def index
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
    @customer = current_customer
    case step
    when :address
      @countries = Country.all
      @billing_address = Address.find_or_init_billing_address(@customer)
      @shipping_address = Address.find_or_init_shipping_address(@customer)
    end
    render_wizard
  end

  def update
    @customer = current_customer
    case step
    when :address
      @billing_address = BillingAddress.find_or_create_by(customer_id: current_customer.id)
      @billing_address.update(billing_address_params)
      @shipping_address = ShippingAddress.find_or_create_by(customer_id: current_customer.id)
      @shipping_address.update(shipping_address_params)
    end
    render_wizard
  end

  private

    def billing_address_params
      params.require(:billing_address).permit([:firstname, :lastname, :address, :city, :country_id, :country, :zipcode, :phone])
    end

    def shipping_address_params
      params.require(:shipping_address).permit(:firstname, :lastname, :address, :city, :country_id, :country, :zipcode, :phone)
    end
end
