class RatingsController < ApplicationController
  before_action :authenticate_customer!
  load_and_authorize_resource :book
  load_and_authorize_resource :rating, :through => :book
  load_and_authorize_resource param_method: :rating_params

  def new
    if @book.ratings.find_by(customer_id: current_customer.id)
      flash[:error] = 'You have already left a review'
      redirect_to @book
    end
  end

  def create
    if @rating.save
      redirect_to @book, notice: 'Thank you for your review'
    else
      render 'new'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :review)
  end
end
