class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin_user_account!, except: [:pages]
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  private
  # logout redirect path
  def after_sign_out_path_for(resource_or_scope)
      new_admin_user_account_session_path
  end
  def current_user
    current_admin_user_account.user
  end

end
