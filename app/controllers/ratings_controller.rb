class RatingsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @book = Book.find(params[:book_id])
    @rating = Rating.new
  end

  def create
    @book = Book.find(params[:book_id])
    @rating = @book.ratings.build(rating_params)
    @rating.customer_id = current_customer.id if current_customer
    @rating.save
    if @rating.save
      redirect_to @book
      flash[:notice] = "Thank you for your review"
    else
      flash.now[:error] = "Add rating and review or press 'Cancel'"
      render 'new'
    end
  end

  private

   def rating_params
    params.require(:rating).permit(:rating, :review)
   end
end
