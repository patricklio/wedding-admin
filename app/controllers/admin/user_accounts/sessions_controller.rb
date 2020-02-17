# frozen_string_literal: true

class Admin::UserAccounts::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:admin_user_account, keys: [:email, :password])
  end
end
