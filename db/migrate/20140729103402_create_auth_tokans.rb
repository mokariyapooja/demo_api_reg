class CreateAuthTokans < ActiveRecord::Migration
  def change
    create_table :auth_tokans do |t|
      t.string :user_id
      t.string :tokan

      t.timestamps
    end
  end
end
