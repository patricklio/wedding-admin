class CreatePartnerUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :phone_number
      t.string :role
      t.string :firstname
      t.string :lastname
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
