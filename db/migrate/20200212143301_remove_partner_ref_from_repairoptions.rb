class RemovePartnerRefFromRepairoptions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :repairoptions, :partner, null: false, foreign_key: true
  end
end
