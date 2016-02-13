class SettingsController < ApplicationController

  def index
    @customer = current_customer
    @countries = Country.all
    @billing_address = Address.find_or_initialize_by(customer_id: @customer.id, type: "BillingAddress")
    @shipping_address = Address.find_or_initialize_by(customer_id: @customer.id, type: "ShippingAddress")
  end

  def update_billing_address
    @billing_address = Address.find_or_create_by(customer_id: current_customer.id, type: "BillingAddress")
    if @billing_address.update(billing_address_params)
      redirect_to :back
    else
      redirect_to :back
      flash[:error] = "Please fill in all of the required fields"
    end
  end

    def update_shipping_address
    @shipping_address = Address.find_or_create_by(customer_id: current_customer.id, type: "ShippingAddress")
    if @shipping_address.update(shipping_address_params)
      redirect_to :back
    else
      redirect_to :back
      flash[:error] = "Please fill in all of the required fields"
    end
  end

  private

  def billing_address_params
    params.require(:billing_address).permit(:firstname, :lastname, :address, :city, :country_id, :country, :zipcode, :phone)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:firstname, :lastname, :address, :city, :country_id, :country, :zipcode, :phone)
  end
end
