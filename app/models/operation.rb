class Operation < ApplicationRecord

  def self.include_joboperations_counts
    joins(
     %{
       LEFT OUTER JOIN (
         SELECT b.operation_id, COUNT(*) joboperations_count
         FROM   joboperations b
         GROUP BY b.operation_id
       ) a ON a.operation_id = operations.id
     }
    ).select("operations.*, COALESCE(a.joboperations_count, 0) AS joboperations_count")
  end
end
