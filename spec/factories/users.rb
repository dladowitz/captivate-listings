# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name Faker::Name.name
    email Faker::Internet.email
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end
end
