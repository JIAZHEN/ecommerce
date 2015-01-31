class CreatePaymentItems < ActiveRecord::Migration
  def change
    create_table :payment_items do |t|
      t.integer :payment_id
      t.integer :product_id
      t.float :price
      t.integer :qty
      t.float :total

      t.timestamps
    end
    add_index :payment_items, :payment_id
    add_index :payment_items, :product_id
  end
end
