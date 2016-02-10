# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :download do
    association :user
    association :property
    association :disclosure
  end
end
