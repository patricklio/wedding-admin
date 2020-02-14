class CreateJoboperations < ActiveRecord::Migration[6.0]
  def change
    create_table :joboperations do |t|
      t.decimal :labor
      t.references :operation, null: false, foreign_key: true
      t.references :repairoption, null: false, foreign_key: true

      t.timestamps
    end
  end
end
