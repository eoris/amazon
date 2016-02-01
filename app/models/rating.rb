class Rating < ActiveRecord::Base
  belongs_to :customer
  belongs_to :book

  validates :rating, :review, presence: true
  validates_numericality_of :rating, less_than_or_equal_to: 10
  validates_numericality_of :rating, greater_than_or_equal_to: 0
end
