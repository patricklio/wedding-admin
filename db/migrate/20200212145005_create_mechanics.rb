class CreateMechanics < ActiveRecord::Migration[6.0]
  def change
    create_table :mechanics do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone_number
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
