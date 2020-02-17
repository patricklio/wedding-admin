class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user_account!
  def edit
    @user_profile = current_admin_user_account.user
    @user_account = current_admin_user_account
  end

  def update
    @user_account = current_admin_user_account
    @user_profile = current_admin_user_account.user

    @user = User.find(@user_profile.id)

    respond_to do |f|
      if @user.update(admin_user_params)
        f.html { redirect_to admin_edit_user_profile_url, notice: "Votre profil a été modifiés avec succès." }
        f.json { render json: @user, status: :ok }
        flash[:notice]="Votre profil a été modifiés avec succès."
      else
        f.html { render :edit, alert: "Une erreur s'est produite, veuillez reprendre!" }
        f.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end


  private
  def admin_user_params
    params.require(:user).permit(:firstname, :lastname, :email, :phone_number)
  end
end
