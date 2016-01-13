class BooksController < ApplicationController
  def index
    @books = Book.first
  end
end
