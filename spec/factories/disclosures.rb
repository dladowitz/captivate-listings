# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :disclosure do
    association :property
    title "Real Estate Transfer Disclosure Statement"
    url "http://www.aws.com/mytds.pdf"
  end
end
