class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @books = @category.books.page(params[:page]).per(9)
  end
end
