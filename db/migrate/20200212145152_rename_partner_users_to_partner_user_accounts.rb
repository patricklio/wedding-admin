class RenamePartnerUsersToPartnerUserAccounts < ActiveRecord::Migration[6.0]
  def change
    rename_table :partner_users, :partner_user_accounts
  end
end
