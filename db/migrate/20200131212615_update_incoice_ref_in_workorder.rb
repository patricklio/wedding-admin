class UpdateIncoiceRefInWorkorder < ActiveRecord::Migration[6.0]
  def change
    change_column_null :workorders, :invoice_id, true
  end
end
