class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user_account!
  before_action :set_user_profile, only: [:edit, :update]
  def edit
  end

  def update

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


  private
  def admin_user_params
    params.require(:user).permit(:firstname, :lastname, :email, :phone_number)
  end

  def set_user_profile
    @user_profile = User.find(current_user.id)
    @user_account = current_admin_user_account
  end
end
