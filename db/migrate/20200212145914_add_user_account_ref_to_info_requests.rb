class AddUserAccountRefToInfoRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :info_requests, :user_account, null: true, foreign_key: true
  end
end
