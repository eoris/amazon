module BooksHelper
  def avg_rating(book)
    book.ratings.average(:rating).round(2)
  end
end
