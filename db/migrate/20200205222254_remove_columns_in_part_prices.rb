class RemoveColumnsInPartPrices < ActiveRecord::Migration[6.0]
  def change
    remove_reference :part_prices, :model, index: true, foreign_key: true
    remove_reference :part_prices, :fuel_type, index: true, foreign_key: true
    remove_reference :part_prices, :partner, index: true, foreign_key: true


    remove_column :part_prices, :vehicle_year

  end
end
