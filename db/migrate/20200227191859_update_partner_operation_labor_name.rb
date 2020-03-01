class UpdatePartnerOperationLaborName < ActiveRecord::Migration[6.0]
  def change
    rename_table :partner_operation_labor, :partner_operation_labors
  end
end
