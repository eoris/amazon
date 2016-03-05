class RatingsController < ApplicationController
  before_action :authenticate_customer!
  before_action :find_book
  load_and_authorize_resource

  def new
    if @book.has_customer_review?(current_customer)
      flash[:error] = 'You have already left a review'
      redirect_to @book
    else
      @rating = Rating.new
    end
  end

  def create
    @rating = @book.ratings.build(rating_params)
    @rating.customer = current_customer
    if @rating.save
      redirect_to @book, notice: 'Thank you for your review'
    else
      render 'new'
      flash.now[:error] = 'Something went wrong'
    end
  end

  private

    def rating_params
      params.require(:rating).permit(:rating, :review)
    end

    def find_book
      @book = Book.find(params[:book_id])
    end
end
