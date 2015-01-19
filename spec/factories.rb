FactoryGirl.define do

  factory :brand do
    sequence(:name) { |n| "brand_#{n}" }
  end

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

    factory :categ_with_products do
      products {
        3.times.map { FactoryGirl.create(:product) }
      }
    end
  end

  factory :product do
    sequence(:name) { |n| "product_#{n}" }
    sequence(:description) { |n| "Lorem ipsum_#{n}" }
    sequence(:description_markup) { |n| "Lorem ipsum_markup_#{n}" }
    sequence(:price) { |n| 0.3 + n }

    factory :product_with_categ do |prod|
      category FactoryGirl.create(:category)
    end
  end

  factory :user do
    name                  "example"
    email                 "example@example.com"
    password              "password"
    password_confirmation "password"
  end
end
