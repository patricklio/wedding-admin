class RemoveLaborFromRepairoptions < ActiveRecord::Migration[6.0]
  def change

    remove_column :repairoptions, :labor, :string
  end
end
