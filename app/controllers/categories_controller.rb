class CategoriesController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
  end
end
