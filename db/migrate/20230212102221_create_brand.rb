class CreateBrand < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :address
      t.integer :owner_id
      t.string :owner_name

      t.timestamps
    end
  end
end
