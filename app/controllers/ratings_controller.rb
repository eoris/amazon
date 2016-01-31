class RatingsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @book = Book.find(params[:book_id])
    @rating = Rating.new
  end

  def create
    @book = Book.find(params[:book_id])
    @rating = @book.ratings.create(rating_params)
    redirect_to @book
  end

  private

   def rating_params
    params.require(:rating).permit(:rating, :review)
   end
end
