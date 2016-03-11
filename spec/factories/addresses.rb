FactoryGirl.define do
  factory :address do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    address   { Faker::Address.street_address }
    zipcode   { Faker::Address.zip }
    city      { Faker::Address.city }
    country_id{ Faker::Number.between(1, 251) }
    phone     { Faker::PhoneNumber.phone_number }
    type      'ShippingAddress'
  end

end
