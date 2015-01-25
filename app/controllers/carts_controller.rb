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

  private

  def cart_hash
    Hash[$redis.hgetall(current_user_cart).map{ |k, v| [k.to_i, v.to_i] }]
  end

  def current_user_cart
    "cart#{current_user.id}"
  end

  def cart_total(cart_hash, products = nil)
    products ||= Product.find(cart_hash.keys)
    products.reduce(0) { |sum, product| sum + product.price * cart_hash[product.id] }
  end
end
