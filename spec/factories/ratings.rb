FactoryGirl.define do
  factory :rating do
    review { Faker::Lorem.paragraph }
    rating { Faker::Number.between(1, 10) }
  end

end
