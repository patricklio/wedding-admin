class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :company_name
      t.text :address
      t.string :phone_number
      t.string :ninea
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :customer_type

      t.timestamps
    end
  end
end
