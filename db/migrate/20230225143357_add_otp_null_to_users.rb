class AddOtpNullToUsers < ActiveRecord::Migration[7.0]
  def change
    User.all.update_all(status: User.statuses[:activated])

    change_column_null :users, :status, false
  end
end
