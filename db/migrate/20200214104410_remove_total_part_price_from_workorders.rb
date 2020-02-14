class RemoveTotalPartPriceFromWorkorders < ActiveRecord::Migration[6.0]
  def change

    remove_column :workorders, :total_part_price, :decimal
  end
end
