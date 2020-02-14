class ChangeWorkorderInvoiceTypeRefToNull < ActiveRecord::Migration[6.0]
  def change
    # Change the column to allow null
    change_column_null :workorders, :invoice_id, true
  end
end
