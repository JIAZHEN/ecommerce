module CartsHelper
  def cart_hash
    Hash[$redis.hgetall(current_user_cart).map{ |k, v| [k.to_i, v.to_i] }]
  end

  def cart_total(cart_hash, products = nil)
    products ||= Product.find(cart_hash.keys)
    products.reduce(0) { |sum, product| sum + product.price * cart_hash[product.id] }.to_f
  end

  def current_user_cart
    "cart#{current_user.id}"
  end

  def clear_cart
    $redis.del current_user_cart
  end
end
