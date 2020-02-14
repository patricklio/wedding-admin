class CreateCustomerNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_notifications do |t|
      t.string :name
      t.text :description
      t.boolean :mark_as_read
      t.references :user_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
