class AddDetailsToBrand < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :vision, :string
  end
end
