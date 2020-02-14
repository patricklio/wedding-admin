class RemoveLaborFromJoboperations < ActiveRecord::Migration[6.0]
  def change

    remove_column :joboperations, :labor, :string
  end
end
