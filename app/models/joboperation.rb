class Joboperation < ApplicationRecord
  has_many :jobparts, dependent: :destroy
  belongs_to :operation
  belongs_to :repairoption

  validates :operation_id, presence: { message: "Le choix d'une opération est obligatoire" }
end
