class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :appointment_time
      t.text :comments
      t.string :status
      t.decimal :review_rate
      t.text :review_comments
      t.references :workorder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
