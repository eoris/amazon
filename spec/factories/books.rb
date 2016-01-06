FactoryGirl.define do
  factory :book do
    title "MyString"
    descirption "MyText"
    price 1.5
    quantity_in_stock 1

    # factory :author do
    #   firstname "MyString"
    #   lastname "MyString"
    #   biography "MyText"
    # end
  end

end
