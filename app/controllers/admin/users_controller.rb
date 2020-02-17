class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user_account!
  before_action :set_user_profile, only: [:edit, :update, :update_password]
  def edit
  end

  def update
    @minimum_password_length = 8

    if @user_profile.update(admin_user_params)
      flash[:success] = "Les données ont bien été modifiées."
      if params[:commit] == "Enregistrer"
        redirect_to root_path
      else
        redirect_to edit_admin_user_url(@user_profiles)
      end
    else
      render :edit
    end
  end

  def update_password
    if @user_account.update(user_account_params)
      # Sign in the user by passing validation in case their password changed
      # bypass_sign_in(@user_account)
      bypass_sign_in @user_account, scope: :admin
      redirect_to root_path
    else
      render "edit"
    end
  end

  private
  def admin_user_params
    params.require(:user).permit(:firstname, :lastname, :email, :phone_number)
  end

  def user_account_params
    params.require(:user_account).permit(:password, :password_confirmation)
  end

  def set_user_profile
    @user_profile = User.find(current_user.id)
    @user_account = current_admin_user_account
  end
end
