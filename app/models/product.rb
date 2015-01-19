class Product < ActiveRecord::Base
  validates :name, presence: true, numericality: true,
                   length: { minimum: 6 }
end
