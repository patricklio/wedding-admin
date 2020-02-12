class AddMechanicRefToAppointmentMechanics < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointment_mechanics, :mechanic, null: false, foreign_key: true
  end
end
