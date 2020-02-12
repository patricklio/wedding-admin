class RemovePartnerUserAccountRefFromAppointmentMechanics < ActiveRecord::Migration[6.0]
  def change
    remove_reference :appointment_mechanics, :partner_user_account, null: false, foreign_key: true
  end
end
