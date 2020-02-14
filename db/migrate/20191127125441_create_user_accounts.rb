class CreateUserAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_accounts do |t|
      t.string :email
      t.string :password
      t.references :customer, null: false, foreign_key: true
      t.references :info_request, null: true, foreign_key: true

      t.timestamps
    end
  end
end
