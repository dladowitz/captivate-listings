# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :download do
    title "MyString"
    url "MyString"
    user_id 1
  end
end
