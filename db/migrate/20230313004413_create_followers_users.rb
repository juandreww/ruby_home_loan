class CreateFollowersUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :followers_users do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :followed_at
      t.references :user_follower, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
