class RatingsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @book = Book.find(params[:book_id])
    if @book.ratings.map(&:customer_id).include? current_customer.id
      flash[:error] = "You have already left a review"
      redirect_to @book
    else
      @rating = Rating.new
    end
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

  def destroy
    @book = Book.find(params[:book_id])
    @rating = @book.ratings.find(params[:id])
    @rating.destroy
  end

  private

   def rating_params
    params.require(:rating).permit(:rating, :review)
   end
end
