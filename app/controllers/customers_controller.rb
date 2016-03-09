class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  before_action :addresses_init

  def edit
    authorize! :edit, @customer
  end

  def update
    authorize! :update, @customer
    if params[:customer] && @customer.update(customer_params)
      flash[:notice] = 'Your personal data updated'
      redirect_to edit_customer_path
    elsif params[:passwords] && @customer.update_with_password(passwords_params)
      sign_in @customer, bypass: true
      flash[:notice] = 'Password Changed'
      redirect_to edit_customer_path
    else
      render 'edit'
    end
  end

  def update_addresses
    authorize! :update_addresses, @customer
    if params[:billing_address] && @billing_address.update(billing_params)
      flash[:notice] = 'Billing address is updated'
      redirect_to edit_customer_path
    elsif params[:shipping_address] && @shipping_address.update(shipping_params)
      flash[:notice] = 'Shipping address is updated'
      redirect_to edit_customer_path
    else
      render 'edit'
    end
  end

  private

  def addresses_init
    @countries = Country.all
    @billing_address = BillingAddress.find_or_initialize_by(customer_id: @customer.id)
    @shipping_address = ShippingAddress.find_or_initialize_by(customer_id: @customer.id)
  end

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :email)
  end

  def passwords_params
    params.require(:passwords).permit(:password,
                                      :current_password,
                                      :password_confirmation)
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
end
