FactoryGirl.define do
  factory :admin do
    encrypted_password  { Faker::Internet.password }
    email     { Faker::Internet.email }
  end

end
