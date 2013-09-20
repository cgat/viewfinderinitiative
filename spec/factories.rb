include ActionDispatch::TestProcess #include so that we can use the { fixture_file_upload with carrierwave uploads

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Test User#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }

    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end

  factory :project do
    name "Glacier Project"
    description "This is the Glacier Project"
  end

  factory :station do
    name "Illecillewaet Glacier"
    description "This is station number 1"
    after(:create) do |this_station|
      FactoryGirl.create(:repeat_pair, station: this_station)
    end
    project
  end

  factory :repeat_pair do
    historic_image
    repeat_image
    station
  end

  factory :historic_image do
    image { fixture_file_upload(File.join('spec','photos','test_historic_image.jpg')) }
    date Date.new(1887,07,22)
  end

  factory :repeat_image do
    image { fixture_file_upload(File.join('spec','photos','test_repeat_image.jpg')) }
    date Date.new(2011,07,22)
    after(:create) do |this_rimage|
      FactoryGirl.create_list(:point, 3, pointsable_type: this_rimage.class.name, pointsable_id: this_rimage.id)
    end
  end

  factory :user_repeat_image do
    image { fixture_file_upload(File.join('spec','photos','test_user_repeat_image.jpg')) }
    date  Date.new(2013,07,22)
    user
    repeat_pair
    factory :user_repeat_image_too_long do
      image { fixture_file_upload(File.join('spec','photos','too_long_image.jpg')) }
    end
    factory :user_repeat_image_too_large do
      image { fixture_file_upload(File.join('spec','photos','too_large_image.jpg')) }
    end
    trait :with_points do
      after(:create) do |this_image|
        FactoryGirl.create_list(:point, 3, pointsable_type: this_image.class.name, pointsable_id: this_image.id)
      end
    end
  end

  factory :point, :class => Pointsable::Points do
    sequence(:label) { |n| "p#{n}" }
    sequence(:x) { |n| n+100 }
    sequence(:y) { |n| n+200 }
  end

end
