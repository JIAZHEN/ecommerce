FactoryGirl.define do
  factory :user do
    name                  "example"
    email                 "example@example.com"
    password              "password"
    password_confirmation "password"
  end
end