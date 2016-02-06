module RatingsHelper
  def avg_rating(book)
    rating = book.ratings.average(:rating)
    if rating.nil?
      return
    else
      rating.round(2)
    end
  end
end
