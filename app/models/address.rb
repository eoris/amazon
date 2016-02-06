class Address < ActiveRecord::Base
  belongs_to :customer
  belongs_to :country
  validates :address, :zipcode, :city, :phone,
            :customer_id, :country_id, presence: true
end
