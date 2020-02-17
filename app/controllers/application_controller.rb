class ApplicationController < ActionController::Base
  def current_user
    current_admin_user_account.user
  end
end
