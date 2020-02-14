class AddTotalPartPriceToWorkorders < ActiveRecord::Migration[6.0]
  def change
    add_column :workorders, :total_part_price, :decimal, null: true
  end
end
