class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def bestsellers
    @books = Book.page(params[:page]).per(1)
  end
end
