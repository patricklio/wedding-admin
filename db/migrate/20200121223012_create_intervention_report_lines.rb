class CreateInterventionReportLines < ActiveRecord::Migration[6.0]
  def change
    create_table :intervention_report_lines do |t|
      t.references :intervention_report, null: false, foreign_key: true
      t.references :jobpart, null: false, foreign_key: true
      t.string :part_reference

      t.timestamps
    end
  end
end
