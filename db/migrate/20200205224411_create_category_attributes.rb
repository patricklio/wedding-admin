class CreateCategoryAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :category_attributes do |t|
      t.references :model, null: false, foreign_key: true
      t.references :fuel_type, null: false, foreign_key: true
      t.references :vehicle_category, null: false, foreign_key: true
      t.integer :vehcile_year

      t.timestamps
    end
  end
end
