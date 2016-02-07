class Book < ActiveRecord::Base
  belongs_to :category
  has_many :ratings
  has_many :order_items
  has_and_belongs_to_many :authors

  validates :title, :price, :quantity_in_stock, presence: true
  validates_numericality_of :price
  validates_numericality_of :quantity_in_stock, greater_than_or_equal_to: 0
end
