class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :reference
      t.date :creation_date
      t.string :status
      t.text :comments

      t.timestamps
    end
  end
end
