# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :historic_image do
    image "MyString"
    date "2013-07-22"
    station nil
  end
end
