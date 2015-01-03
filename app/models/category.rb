class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :subs,
           class_name: "Category",
           foreign_key: "parent_id",
           dependent: :destroy

  belongs_to :parent,
              class_name: "Category",
              foreign_key: "parent_id"

end
