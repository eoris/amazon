FactoryGirl.define do
  factory :book do
    title             { Faker::Book.title }
    description       { Faker::Lorem.paragraph }
    price             { Faker::Commerce.price }
    quantity_in_stock { Faker::Number.digit }
  end

end
