class RepairoptionCategory < ApplicationRecord
  validates :name,
    presence: {
      message: "Le nom de la catégorie est obligatoire"
    },
    uniqueness: {
      case_sensitive: false,
      message: ->(object, data) do
        "La catégorie #{data[:value]} existe déja!"
      end
    }

  validates :description, presence: {message: "La description est obligatoire"}
end
