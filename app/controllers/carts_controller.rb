class CartsController < ApplicationController
  before_action :logged_in_user

  def show
    @cart_hash = cart_hash
    @cart_products = Product.find(@cart_hash.keys)
    @cart_total = cart_total(@cart_hash, @cart_products)
  end

  def add
    $redis.hincrby current_user_cart, params[:product_id], params[:qty]
    render json: { count: current_user.cart_count }, status: 200
  end

  def remove
    $redis.hdel current_user_cart, params[:product_id]
    render json: { count: current_user.cart_count, total: cart_total(cart_hash) }, status: 200
  end
end
