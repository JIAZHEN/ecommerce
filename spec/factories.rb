FactoryGirl.define do

  factory :category do
    sequence(:name) { |n| "category_#{n}" }

    factory :categ_with_descendants do
      after(:create) do |category|
        3.times do
          sub = FactoryGirl.create(:category)
          sub.move_to_child_of(category)
        end
      end
    end

    factory :categ_with_parent do
      after(:create) do |category|
        parent = FactoryGirl.create(:category)
        category.move_to_child_of(parent)
      end
    end
  end

  factory :user do
    name                  "example"
    email                 "example@example.com"
    password              "password"
    password_confirmation "password"
  end
end
