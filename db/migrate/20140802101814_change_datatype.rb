class ChangeDatatype < ActiveRecord::Migration
  def up
    change_column :users, :phonenumber, :integer
  end

  def down
    change_column :users, :phonenumber, :decimal
  end
end
