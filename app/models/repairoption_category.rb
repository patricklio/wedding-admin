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

  def self.include_repairoptions_counts
    joins(
     %{
       LEFT OUTER JOIN (
         SELECT b.repairoption_category_id, COUNT(*) repairoptions_count
         FROM   repairoptions b
         GROUP BY b.repairoption_category_id
       ) a ON a.repairoption_category_id = repairoption_categories.id
     }
    ).select("repairoption_categories.*, COALESCE(a.repairoptions_count, 0) AS repairoptions_count")
  end
end
