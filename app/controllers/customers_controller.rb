class CustomersController < ApplicationController

before_action :authenticate_customer!

ERROR  = "Please fill in all of the required fields"

  def edit
    @customer = current_customer
    @countries = Country.all
    @billing_address = Address.find_or_init_billing_address(@customer)
    @shipping_address = Address.find_or_init_shipping_address(@customer)
  end

  def update_personal_data
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_personal_data_params)
      redirect_to :back, notice: "Your personal data updated"
    else
      redirect_to :back
      flash[:error] = ERROR
    end
  end

  def update_password
    @customer = Customer.find(current_customer.id)
    if @customer.update_with_password(customer_params)
      sign_in @customer, :bypass => true
      redirect_to :back, notice: "Password Changed"
    else
      redirect_to :back
      flash[:error] = ERROR
    end
  end

  def update_billing_address
    @billing_address = BillingAddress.find_or_create_by(customer_id: current_customer.id)
    if @billing_address.update(billing_address_params)
      redirect_to :back, notice: "Billing address is updated"
    else
      redirect_to :back
      flash[:error] = ERROR
    end
  end

  def update_shipping_address
    @shipping_address = ShippingAddress.find_or_create_by(customer_id: current_customer.id)
    if @shipping_address.update(shipping_address_params)
      redirect_to :back, notice: "Shipping address is updated"
    else
      redirect_to :back
      flash[:error] = ERROR
    end
  end

  def destory
  end

  private

    def customer_personal_data_params
      params.require(:customer).permit(:firstname, :lastname, :email)
    end

    def customer_params
      params.require(:customer).permit(:password, :current_password, :password_confirmation)
    end

    def billing_address_params
      params.require(:billing_address).permit([:firstname, :lastname, :address, :city, :country_id, :country, :zipcode, :phone])
    end

    def shipping_address_params
      params.require(:shipping_address).permit(:firstname, :lastname, :address, :city, :country_id, :country, :zipcode, :phone)
    end
end
