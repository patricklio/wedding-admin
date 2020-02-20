class InfoRequest < ApplicationRecord
  STATUS = %w(opened closed).freeze
  scope :opened, -> { where(status: 'opened') }
  scope :closed, -> { where(status: 'closed') }

  def self.include_user_firstname_lastname
    joins(
     %{
       LEFT OUTER JOIN (
         SELECT u.id, us.firstname, us.lastname
         FROM   user_accounts u
         INNER JOIN users us ON u.user_id = us.id
       ) a ON a.id = info_requests.user_account_id
     }
    ).select("info_requests.*, a.firstname AS user_firstname, a.lastname AS user_lastname")
  end
end
