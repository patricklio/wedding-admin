class RenamePartnerUserIdInInterventionReports < ActiveRecord::Migration[6.0]
  def change
    rename_column :intervention_reports, :partner_user_id, :partner_user_account_id
  end
end
