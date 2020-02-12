class RenameUserAccountsToCustomerUserAccounts < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_accounts, :customer_user_accounts
  end
end
