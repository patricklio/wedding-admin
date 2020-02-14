class RemoveRepairoptionRefFromJobparts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :jobparts, :repairoption, null: false, foreign_key: true
  end
end
