class CreatePartPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :part_prices do |t|
      t.references :part, null: false, foreign_key: true
      t.references :model, null: false, foreign_key: true
      t.integer :vehicle_year
      t.references :fuel_type, null: false, foreign_key: true
      t.decimal :part_price

      t.timestamps
    end
  end
end
