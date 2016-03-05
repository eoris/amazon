class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.order(:title)
  end

  def show
    @categories = Category.order(:title)
    @books = @category.books.page(params[:page]).per(9)
  end
end
