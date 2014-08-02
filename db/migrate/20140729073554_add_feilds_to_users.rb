class AddFeildsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :text
    add_column :users, :lastname, :text
    add_column :users, :phonenumber, :number
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :device_id, :string
    add_column :users, :device_type, :string
  end
end
