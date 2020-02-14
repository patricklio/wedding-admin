class CreateWorkorders < ActiveRecord::Migration[6.0]
  def change
    create_table :workorders do |t|
      t.string :number
      t.text :address
      t.string :status
      t.decimal :total_price
      t.date :workorder_date
      t.string :currency
      t.references :vehicle, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.references :user_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
