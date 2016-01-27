class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings
  has_many :addresses
  has_many :credit_cards

  validates :password, :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
