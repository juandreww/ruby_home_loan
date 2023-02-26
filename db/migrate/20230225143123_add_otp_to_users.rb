class AddOtpToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp, :string
    add_column :users, :status, :integer
  end
end