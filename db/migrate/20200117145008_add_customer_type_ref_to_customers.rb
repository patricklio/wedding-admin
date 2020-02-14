class AddCustomerTypeRefToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_reference :customers, :customer_type, null: false, foreign_key: true
  end
end
