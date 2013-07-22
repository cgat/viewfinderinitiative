# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_repeat_image do
    image "MyString"
    date "2013-07-22"
    user nil
    historic_image nil
  end
end
