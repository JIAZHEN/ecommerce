namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    ["success", "fail", "error", "processing"].each { |status| PaymentStatus.create(name: status) }
    %w(chair Couch Bed Daybed Futon Hammock Headboard Mattress table Chabudai
      Desk Kotatsu Korsi Lowboy Pedestal Bookcase Cabinetry Ottoman
      Shelving Wardrobe).each do |name|
      Category.create!(name: name)
    end
    sub_categ_names = ["Bathroom cabinet", "Closet", "Cupboard",
      "Curio cabinet", "Hutch","Hoosier cabinet",
      "Kitchen cabinet", "Pantry", "Pie safe"]

    ["into", "corbusier", "Charles & Ray Eames", "Eero Saarinen",
    "Jean Prouve", "Paul McCobb", "Ettore Sottsass", "knoll",
    "Edward Wormley", "Milo Baughmann", "Charlotte Perriand",
    "Ludwig Mies van der Rohe", "George Nelson", "Harry Bertoia",
    "Marcel Breuer", "Issamu Noguchi", "maloof", "George Nakashima",
    "Alvar Aalto", "Gaetano Pesce"].each do |name|
      Brand.create!(name: name)
    end

    categs = Category.take(20)
    brands = Brand.take(20)

    3.times do
      categs.each do |categ|
        Category.create!(name: sub_categ_names.sample).move_to_child_of(categ)
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
