class CreateUserSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sessions do |t|
      t.string :ip_address
      t.datetime :start_time
      t.datetime :expired_time
      t.references :user_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
