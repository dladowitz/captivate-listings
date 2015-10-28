# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    association :property
    position 1
    url "https://placekitten.com/200/300"
  end
end
