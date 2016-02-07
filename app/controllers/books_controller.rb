class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(9)
    @categories = Category.order(:title)
  end

  def show
    @book = Book.find(params[:id])
    order_item_initialize
  end

  def bestsellers
    @books = Book.page(params[:page]).per(9)
    @order_item = OrderItem.new
  end

  private

    def order_item_initialize
      @order_item = OrderItem.new(book_id: @book.id)
    end
end
