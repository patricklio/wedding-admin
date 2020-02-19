class Part < ApplicationRecord
  validates :part_desc, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 1}

  def self.include_jobparts_counts
    joins(
     %{
       LEFT OUTER JOIN (
         SELECT b.part_id, COUNT(*) jobparts_count
         FROM   jobparts b
         GROUP BY b.part_id
       ) a ON a.part_id = parts.id
     }
    ).select("parts.*, COALESCE(a.jobparts_count, 0) AS jobparts_count")
  end
end
