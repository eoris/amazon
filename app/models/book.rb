class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings, through: :customers

  validates :title, :price, :quantity_in_stock, presence: true
end
