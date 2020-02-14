class CreateAppointmentMechanics < ActiveRecord::Migration[6.0]
  def change
    create_table :appointment_mechanics do |t|
      t.references :appointment, null: false, foreign_key: true
      t.references :partner_user, null: false, foreign_key: true
      t.boolean :lead_mechanic

      t.timestamps
    end
  end
end
