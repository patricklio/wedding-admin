class CreateJobparts < ActiveRecord::Migration[6.0]
  def change
    create_table :jobparts do |t|
      t.references :part, null: false, foreign_key: true
      t.references :joboperation, null: true, foreign_key: true
      t.references :repairoption, null: true, foreign_key: true
      t.integer :part_qty

      t.timestamps
    end
  end
end
