class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand

  validates :name, presence: true, length: { minimum: 6 }
  validates :price, numericality: true

  def cart_action(current_user_id)
    $redis.hget("cart#{current_user_id}", id) ? "Remove from" : "Add to"
  end
end
