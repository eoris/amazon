class CategoriesController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(9)
  end
end
