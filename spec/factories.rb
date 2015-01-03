FactoryGirl.define do

  factory :category do
    sequence(:name) { |n| "category_#{n}" }

    factory :categ_with_subs do |sub|
      subs {
        3.times.map { FactoryGirl.create(:category) }
      }
    end

    factory :categ_with_parent do |sub|
      parent FactoryGirl.create(:category)
    end
  end

  factory :user do
    name                  "example"
    email                 "example@example.com"
    password              "password"
    password_confirmation "password"
  end
end
