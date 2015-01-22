namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    20.times { Category.create!(name: Faker::Company.name) }
    20.times { Brand.create!(name: Faker::Commerce.department) }
    categs = Category.take(20)
    brands = Brand.take(20)

    3.times do
      categs.each do |categ|
        Category.create!(name: Faker::Company.name).move_to_child_of(categ)
      end
    end

    subcategs = categs.reduce([]) {|sum, categ| sum + categ.reload.descendants}

    100.times do |n|
      Product.create(name: Faker::Commerce.product_name,
       price: Faker::Number.number(2).to_f + 0.3,
       description: Faker::Lorem.sentence(9),
       description_markup: Faker::Lorem.sentence(3),
       category_id: subcategs.sample.id,
       brand_id: brands.sample.id)
    end

    Category.find_each(&:save)
    Product.find_each(&:save)
  end
end
