# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :download do
    association :user
    association :property
    title "855-Front-St-TDS.pdf"
    url "http://aws.com/855-Front-St-TDS.pdf"
  end
end
