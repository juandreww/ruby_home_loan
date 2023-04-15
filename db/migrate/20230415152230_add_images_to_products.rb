class AddImagesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :images, :json
  end
end
