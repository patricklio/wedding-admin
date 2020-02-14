class AddPartnerRefToPartPrices < ActiveRecord::Migration[6.0]
  def change
    add_reference :part_prices, :partner, null: false, foreign_key: true
  end
end
