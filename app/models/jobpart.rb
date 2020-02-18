class Jobpart < ApplicationRecord
  belongs_to :part
  belongs_to :joboperation

  validates :joboperation_id, presence: { message: "Le choix d'une opération est obligatoire" }
  validates :part_id, presence: { message: "Le choix d'une pièce est obligatoire" }
  validates :part_qty,
    numericality: {
      greater_than: 0,
      message: "La quantité de la pièce doit être supérieure à 0"
    }
end
