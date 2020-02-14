class UpdateColumnVehicleYearName < ActiveRecord::Migration[6.0]
  def change
    rename_column :category_attributes, :vehcile_year, :vehicle_year
  end
end
