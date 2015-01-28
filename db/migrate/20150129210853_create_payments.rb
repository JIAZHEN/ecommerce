class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.float :amount
      t.float :shipping_cost
      t.integer :payment_status_id

      t.timestamps
    end
    add_index :payments, :user_id
    add_index :payments, :payment_status_id
  end
end
