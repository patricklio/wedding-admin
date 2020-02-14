class CreateCustomerTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
