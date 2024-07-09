FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    first_name { 'Firstname' }
    last_name { 'Lastname' }
    password { 'simplepass' }
    password_confirmation { 'simplepass' }
  end
end
