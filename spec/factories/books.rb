FactoryGirl.define do
  factory :book do
    title             { Faker::Book.title }
    descirption       { Faker::Lorem.paragraph }
    price             { Faker::Commerce.price }
    quantity_in_stock { Faker::Number.digit }
  end

end
