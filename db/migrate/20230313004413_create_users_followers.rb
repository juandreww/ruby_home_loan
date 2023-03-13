class CreateUsersFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :users_followers do |t|
      
      t.timestamps
    end
  end
end
