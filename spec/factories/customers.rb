FactoryGirl.define do
  factory :customer do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    password  { Faker::Internet.password }
    email     { Faker::Internet.email }
  end
end
