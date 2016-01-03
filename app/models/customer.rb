class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings

  validates :password, :firstname, :lastname, presence: true
  validates :password, uniqueness: true
end
