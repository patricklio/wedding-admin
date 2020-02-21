class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin_user_account!
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

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    query_name = exception.query

    flash[:alert] = t "#{policy_name}.#{query_name}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

end
