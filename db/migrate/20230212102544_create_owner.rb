class CreateOwner < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :password, null: false
      t.string :phone, null: false
      t.string :user_uuid, null: false

      t.timestamps
    end
  end
end
