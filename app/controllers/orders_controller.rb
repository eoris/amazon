class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer
  load_and_authorize_resource
  def index
  end

  def show
  end
end
