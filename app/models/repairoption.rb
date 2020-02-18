class Repairoption < ApplicationRecord
  belongs_to :repairoption_category
  has_many  :joboperations
  validates :repairoption_category_id, presence: { message: "La catégorie est obligatoire" }
  validates :description, presence: {message: "La description du service est obligatoire"}
  validates :name,
            presence: {
                message: "Le nom du service est obligatoire"
            },
            uniqueness: {
                message: ->(object, data) do
                  "Le service #{data[:value]} existe déja!"
                end
            }
end
