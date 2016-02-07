module RatingsHelper
  def avg_rating(book)
    number_with_precision(book.ratings.average(:rating), precision: 2)
  end
end
