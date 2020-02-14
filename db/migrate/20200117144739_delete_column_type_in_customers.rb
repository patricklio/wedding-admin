class DeleteColumnTypeInCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :customer_type
  end
end
