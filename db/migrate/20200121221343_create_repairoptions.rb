class CreateRepairoptions < ActiveRecord::Migration[6.0]
  def change
    create_table :repairoptions do |t|
      t.string :name
      t.text :description
      t.boolean :propose_in_option
      t.decimal :labor
      t.references :repairoption_category, null: false, foreign_key: true
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
