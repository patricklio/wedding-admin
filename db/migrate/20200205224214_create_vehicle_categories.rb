class CreateVehicleCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_categories do |t|
      t.string :name
      t.text :description
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
