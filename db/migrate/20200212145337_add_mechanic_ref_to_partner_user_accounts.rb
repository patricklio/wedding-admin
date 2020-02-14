class AddMechanicRefToPartnerUserAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :partner_user_accounts, :mechanic, null: true, foreign_key: true
  end
end
