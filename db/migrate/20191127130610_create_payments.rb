class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :status
      t.date :payment_date
      t.string :payment_type
      t.string :payment_reference
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
