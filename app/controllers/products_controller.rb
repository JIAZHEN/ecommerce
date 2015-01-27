class ProductsController < ApplicationController
  def index
    @new_products = Product.last(3)
    @sellers = Product.take(3)
  end

  def show
    @product = Product.find_by(id: params[:id])
    @cart_action = @product.cart_action current_user.try :id
  end
end
