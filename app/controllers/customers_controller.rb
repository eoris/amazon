class CustomersController < ApplicationController

before_action :authenticate_customer!
before_action :customer_init
before_action :addresses_init, :except => [:edit]

  def edit
    @countries = Country.all
    @billing_address = Address.find_or_init_billing_address(@customer)
    @shipping_address = Address.find_or_init_shipping_address(@customer)
  end

  def update_personal_data
    if @customer.update(customer_personal_data_params)
      flash[:notice] = "Your personal data updated"
      redirect_to edit_customer_path
    else
      render 'edit'
    end
  end

  def update_password
    if @customer.update_with_password(customer_params)
      sign_in @customer, :bypass => true
      flash[:notice] = "Password Changed"
      redirect_to edit_customer_path
    else
      render 'edit'
    end
  end

  def update_billing_address
    @billing_address = BillingAddress.find_or_create_by(customer_id: current_customer.id)
    if @billing_address.update(billing_address_params)
      flash[:notice] = "Billing address is updated"
      redirect_to edit_customer_path
    else
      render 'edit'
    end
  end

  def update_shipping_address
    @shipping_address = ShippingAddress.find_or_create_by(customer_id: current_customer.id)
    if @shipping_address.update(shipping_address_params)
      flash[:notice] = "Shipping address is updated"
      redirect_to edit_customer_path
    else
      render 'edit'
    end
  end

  def destory
  end

  private

    def customer_init
      @customer = current_customer
    end

    def addresses_init
      @billing_address = BillingAddress.find_or_create_by(customer_id: current_customer.id)
      @shipping_address = ShippingAddress.find_or_create_by(customer_id: current_customer.id)
    end

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
