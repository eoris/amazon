class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(9)
    @categories = Category.order(:title)
  end

  def show
    @book = Book.find(params[:id])
  end

  def bestsellers
    @books = Book.bestsellers(5)
  end
end
