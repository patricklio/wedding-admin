class UpdatePartners < ActiveRecord::Migration[6.0]
  def change
    remove_column :partners, :margin_rate

    add_column :partners, :longitude, :string
    add_column :partners, :latitude, :string
    add_column :partners, :opening_hours_monday, :string
    add_column :partners, :opening_hours_tuesday, :string
    add_column :partners, :opening_hours_wednesday, :string
    add_column :partners, :opening_hours_thursday, :string
    add_column :partners, :opening_hours_friday, :string
    add_column :partners, :opening_hours_saturday, :string
    add_column :partners, :opening_hours_sunday, :string
    add_column :partners, :manager_firstname, :string
    add_column :partners, :manager_lastname, :string
    add_column :partners, :opening_year, :integer
    add_column :partners, :experience_year, :integer
  end
end
