class UpdateColumnsInPartners < ActiveRecord::Migration[6.0]
  def change
    remove_column :partners, :latitude
    remove_column :partners, :longitude

    add_column :partners, :logo_url, :string
    add_column :partners, :latitude, :float
    add_column :partners, :longitude, :float
  end
end
