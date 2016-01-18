FactoryGirl.define do
  factory :order_item do
    price    { Faker::Commerce.price }
    quantity { Faker::Number.digit }
  end

end
