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
    if @rating.valid?
      @rating.customer_id = current_customer.id if current_customer
      if @rating.save
        redirect_to @book, notice: "Thank you for your review"
      else
        flash.now[:error] = "Something went wrong"
      end
    else
      render 'new'
    end
  end

  def destroy
    if current_customer && @rating = current_customer.ratings.find(params[:id])
      @rating.destroy
    else
      flash[:error] = "Not authorized customer"
      redirect_to @book
    end
  end

  private

   def rating_params
    params.require(:rating).permit(:rating, :review)
   end
end
