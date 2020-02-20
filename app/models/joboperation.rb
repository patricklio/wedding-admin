class Joboperation < ApplicationRecord
  has_many :jobparts, dependent: :destroy
  belongs_to :operation
  belongs_to :repairoption


  validates :operation_id,
    presence: {
      message: "Le choix d'une opération est obligatoire"
    },
    uniqueness: {
      scope: :repairoption,
      message: "Cette opération est déjà dans la repairoption"
    }
  validates :repairoption_id, presence: { message: "Le choix d'un service est obligatoire" }

  def self.include_operation_name_repairoption_name
    joins(
      %{
        JOIN operations o ON o.id = joboperations.operation_id
        JOIN repairoptions r ON r.id = joboperations.repairoption_id
        LEFT OUTER JOIN (
          SELECT j.joboperation_id, COUNT(*) jobparts_count
          FROM   jobparts j
          GROUP BY j.joboperation_id
        ) a ON a.joboperation_id = joboperations.id
      }
    ).select("joboperations.*,
              o.name AS operation_name,
              r.name AS repairoption_name,
              COALESCE(a.jobparts_count, 0) AS jobparts_count")
  end
end
