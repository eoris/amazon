class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings

  validates :password, :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
