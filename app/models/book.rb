class Book < ActiveRecord::Base
  belongs_to :category
  has_many :ratings
  has_and_belongs_to_many :authors

  validates :title, :price, :quantity_in_stock, presence: true
  validates :price, numericality: true
  validates :quantity_in_stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
