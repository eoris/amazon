class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:title)
  end

  def show
    @categories = Category.order(:title)
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page]).per(9)
  end
end
