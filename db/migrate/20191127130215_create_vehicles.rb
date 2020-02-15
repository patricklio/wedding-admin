class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :VIN
      t.string :license_plate
      t.integer :doors_number
      t.integer :seats_number
      t.decimal :mileage
      t.date :purchase_date
      t.string :engine
      t.decimal :power
      t.integer :year
      t.references :customer, null: false, foreign_key: true
      t.references :fuel_type, null: false, foreign_key: true
      t.references :model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
