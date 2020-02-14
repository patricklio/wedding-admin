class UpdateLaborPriceTypeInPartner < ActiveRecord::Migration[6.0]
  def change
    change_column :partners, :labor_hour_price, :decimal
  end
end
