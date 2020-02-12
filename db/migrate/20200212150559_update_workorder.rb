class UpdateWorkorder < ActiveRecord::Migration[6.0]
  def change
    rename_column :workorders, :user_account_id, :customer_user_account_id

    add_column :workorders, :total_labor_amount, :decimal
    add_column :workorders, :total_part_amount, :decimal
    add_column :workorders, :total_tax_amount, :decimal
  end
end
