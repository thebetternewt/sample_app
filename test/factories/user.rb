FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    sequence :email do |n|
      "user-#{n}@example.com"
    end
    password_digest User.digest('password')
  end
end
