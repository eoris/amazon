class Address < ActiveRecord::Base
  belongs_to :customer
  belongs_to :country
  validates :firstname, :lastname,
            :address, :zipcode, :city, :phone,
            :country_id, presence: true
end
