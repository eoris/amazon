class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockabley, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :ratings
  has_many :addresses
  has_many :credit_cards

  validates :encrypted_password, :firstname, :lastname, :email, presence: true
end
