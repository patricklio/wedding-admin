class CreateRepairoptionDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :repairoption_discounts do |t|
      t.decimal :discount
      t.references :repairoption, null: false, foreign_key: true
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
