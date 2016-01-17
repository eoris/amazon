FactoryGirl.define do
  factory :customer do
    firstname "MyString"
    lastname "MyString"
    password "MyString"
    email { Faker::Internet.email }
  end

end
