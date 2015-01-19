class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :brand_id
      t.integer :category_id
      t.text :description
      t.text :description_markup
      t.integer :product_type_id

      t.timestamps
    end
    add_index :products, :name
  end
end
