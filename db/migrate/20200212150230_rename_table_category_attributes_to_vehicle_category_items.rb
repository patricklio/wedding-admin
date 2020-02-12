class RenameTableCategoryAttributesToVehicleCategoryItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :category_attributes, :vehicle_category_items
  end
end
