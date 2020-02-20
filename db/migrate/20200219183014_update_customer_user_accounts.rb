class UpdateCustomerUserAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_user_accounts, :firstname, :string
    add_column :customer_user_accounts, :lastname, :string
  end
end
