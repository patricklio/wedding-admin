class RenameProposeInOptionInRepairoptions < ActiveRecord::Migration[6.0]
  def change
    rename_column :repairoptions, :propose_in_option, :optional
  end
end
