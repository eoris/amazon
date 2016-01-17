class BooksController < ApplicationController
  def index
    @book = Book.first
  end
end
