class AddPartnerRefToWorkorders < ActiveRecord::Migration[6.0]
  def change
    add_reference :workorders, :partner, null: false, foreign_key: true
  end
end
