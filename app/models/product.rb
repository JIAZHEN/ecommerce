class Product < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true, length: { minimum: 6 }
  validates :price, numericality: true
end
