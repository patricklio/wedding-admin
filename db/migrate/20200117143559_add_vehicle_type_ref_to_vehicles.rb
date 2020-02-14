class AddVehicleTypeRefToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_reference :vehicles, :vehicle_type, null: false, foreign_key: true
  end
end
