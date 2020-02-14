class RenameUserAccountIdInCustomerNotifications < ActiveRecord::Migration[6.0]
  def change
    rename_column :customer_notifications, :user_account_id, :customer_user_account_id
  end
end
