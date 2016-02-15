class SettingsController < ApplicationController

  def index
    @customer = current_customer
    @countries = Country.all
    @billing_address = BillingAddress.find_or_initialize_by(customer_id: @customer.id)
    @shipping_address = ShippingAddress.find_or_initialize_by(customer_id: @customer.id)
  end

  def update_billing_address
    @billing_address = BillingAddress.find_or_create_by(customer_id: current_customer.id)
    if @billing_address.update(billing_address_params)
      redirect_to :back, notice: "Billing address is updated"
    else
      redirect_to :back
      flash[:error] = "Please fill in all of the required fields"
    end
  end

    def update_shipping_address
    @shipping_address = ShippingAddress.find_or_create_by(customer_id: current_customer.id)
    if @shipping_address.update(shipping_address_params)
      redirect_to :back, notice: "Shipping address is updated"
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
