# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property do
    association :user
    address "855 Front St"
    city "San Francisco"
    state "CA"
    zip 94111
    domain_type "subdomain"
    domain "855front.captivatelistings.com"
    sqfeet 1500
    beds 3
    baths 2.5
  end
end
