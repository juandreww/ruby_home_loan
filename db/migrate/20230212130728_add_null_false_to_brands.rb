class AddNullFalseToBrands < ActiveRecord::Migration[7.0]
  def change
    change_column_null :brands, :name, false
    change_column_null :brands, :address, false
  end
end
