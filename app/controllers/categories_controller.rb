class CategoriesController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @books = @category.books.page(params[:page]).per(9)
  end
end
