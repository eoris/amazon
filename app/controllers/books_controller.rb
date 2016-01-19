class BooksController < ApplicationController
  def index
    @book = Book.find_by(id: 14)
    @authors = @book.authors.map {|n| "#{n.firstname} #{n.lastname}" }.to_sentence
  end
end
