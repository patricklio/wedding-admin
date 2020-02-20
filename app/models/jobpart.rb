class Jobpart < ApplicationRecord
  belongs_to :part
  belongs_to :joboperation

  validates :joboperation_id, presence: { message: "Le choix d'une opération est obligatoire" }
  validates :part_id,
    presence: { message: "Le choix d'une pièce est obligatoire" },
    uniqueness: {
      scope: :joboperation,
      message: "Cette pièce est déjà dans la tâche"
    }
  validates :part_qty,
    numericality: {
      greater_than: 0,
      message: "La quantité de la pièce doit être supérieure à 0"
    }

  def self.include_part_desc_joboperation_name
    joins(
      %{
        JOIN parts p ON p.id = jobparts.part_id
        JOIN joboperations j ON j.id = jobparts.joboperation_id
        JOIN operations o ON o.id = j.operation_id
      }
    ).select("jobparts.*,
              p.part_desc AS part_desc,
              o.name AS joboperation_name")
  end
end
