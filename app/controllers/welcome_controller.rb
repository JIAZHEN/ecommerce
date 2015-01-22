class WelcomeController < ApplicationController
  def index
    @new_products = Product.last(3)
    @sellers = Product.take(3)
    @brands = Brand.take(7)
    @feature_products = @brands.map { |brand| brand.products.sample }
  end

  def about
  end

  def contact
  end
end
