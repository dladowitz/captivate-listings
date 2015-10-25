# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property do
    address "855 Front St"
    city "San Francisco"
    state "CA"
    zip 94111
    domain_type "subdomain"
    domain "855front.captivatelistings.com"
  end
end
