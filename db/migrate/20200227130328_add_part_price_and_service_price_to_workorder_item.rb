class AddPartPriceAndServicePriceToWorkorderItem < ActiveRecord::Migration[6.0]
  def change
    add_column :workorder_items, :parts_price, :decimal
    add_column :workorder_items, :service_price, :decimal
  end
end
