class CreatePartnerOperationLabor < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_operation_labor do |t|
      t.decimal :labor
      t.references :partner, null: false, foreign_key: true
      t.references :joboperation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
