class BooksController < ApplicationController
  def index
    @book = Book.find_by(id: 14)
  end

  def show
    @book = Book.find(params[:id])
  end
end
