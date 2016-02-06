class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(9)
    @categories = Category.order(:title)
  end

  def show
    @book = Book.find(params[:id])
    @order_item = OrderItem.new
  end

  def bestsellers
    @books = Book.page(params[:page]).per(9)
    @order_item = OrderItem.new
  end
end
