class CreditCard < ActiveRecord::Base
  belongs_to :customer
  has_many :orders

  validates :number, :cvv, :expiration_month, :expiration_year, presence: true
  validates :number, length: { is: 16 }
  validates :cvv, length: { is: 3 }
  validates_numericality_of :cvv
  validates_numericality_of :number
end
