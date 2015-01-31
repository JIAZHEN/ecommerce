class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :addr_one, :string
    add_column :users, :addr_two, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :postcode, :string
    add_index :users, :postcode
  end
end
