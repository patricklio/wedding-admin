class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :email
      t.money :labor_hour_price
      t.string :labor_currency
      t.decimal :margin_rate

      t.timestamps
    end
  end
end
