class Rating < ActiveRecord::Base
  belongs_to :customer
  belongs_to :book

  validates :rating,
            numericality: { only_integer: true, less_than_or_equal_to: 10 }
end
