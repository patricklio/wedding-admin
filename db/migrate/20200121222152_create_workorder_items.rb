class CreateWorkorderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :workorder_items do |t|
      t.references :workorder, null: false, foreign_key: true
      t.references :repairoption, null: false, foreign_key: true
      t.money :reduction_amount
      t.integer :quantity
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
