class CreateInterventionReports < ActiveRecord::Migration[6.0]
  def change
    create_table :intervention_reports do |t|
      t.references :appointment, null: false, foreign_key: true
      t.references :partner_user, null: false, foreign_key: true
      t.decimal :vehicle_mileage
      t.date :intervention_date
      t.text :comments
      t.decimal :next_mileage

      t.timestamps
    end
  end
end
