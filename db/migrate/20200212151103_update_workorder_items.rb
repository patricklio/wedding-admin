class UpdateWorkorderItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :workorder_items, :reduction_amount, :discount_amount
    rename_column :workorder_items, :tax_rate, :tax_amount
  end
end
