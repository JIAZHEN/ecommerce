class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand

  validates :name, presence: true, length: { minimum: 6 }
  validates :price, numericality: true
end
