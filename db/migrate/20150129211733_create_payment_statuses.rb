class CreatePaymentStatuses < ActiveRecord::Migration
  def change
    create_table :payment_statuses do |t|
      t.string :name

      t.timestamps
    end
    add_index :payment_statuses, :name
  end
end
