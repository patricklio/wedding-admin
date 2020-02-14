class RenamePartnerUserIdInAppointmentMecahnics < ActiveRecord::Migration[6.0]
  def change
    rename_column :appointment_mechanics, :partner_user_id, :partner_user_account_id
  end
end
