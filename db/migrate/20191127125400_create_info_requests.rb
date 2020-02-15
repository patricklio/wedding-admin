class CreateInfoRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :info_requests do |t|
      t.string :company_name
      t.string :firstname
      t.string :lastname
      t.text :company_address
      t.string :working_email
      t.string :phone_number
      t.string :ninea
      t.text :comments
      t.string :status

      t.timestamps
    end
  end
end
