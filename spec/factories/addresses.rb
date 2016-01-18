FactoryGirl.define do
  factory :address do
    address { Faker::Address.street_address }
    zipcode { Faker::Address.zip }
    city    { Faker::Address.city }
    country { Faker::Address.country }
    phone   { Faker::PhoneNumber.phone_number }
  end

end
