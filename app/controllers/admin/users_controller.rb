class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user_account!
  before_action :set_user, only: [:edit, :update, :update_password]

  # GET /admin/users
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # POST /admin/users
  def create
    @user = User.new(admin_user_params)

    respond_to do |format|
      if @user.save
        create_user_account(@user)

        format.html { redirect_to admin_users_path, flash: { success: "l'utilisateur est créé avec succès."} }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    redirect_to admin_users_path
  end

  # GET /admin/users/:id/edit
  def edit
  end

  # PATCH  /admin/users/:id(.:format)
  def update
    @minimum_password_length = 8

    if @user.update(admin_user_params)
      if params[:commit] == "Enregistrer"
        if current_user.admin?
          redirect_to admin_users_path, flash: { success: "Les données ont bien été modifiées."}
        else
          redirect_to root_path
        end
      else
        redirect_to edit_admin_user_path(@user), flash: { success: "Les données ont bien été modifiées."}
      end
    else
      render :edit
    end
  end

  # PATCH  /admin/update_password
  def update_password
    @user_account = current_admin_user_account
    if @user_account.update_with_password(user_account_params)
      sign_in(@user_account, :bypass => true)
      redirect_to edit_admin_user_path(current_admin_user_account), flash: { success: "Password modifié avec  success!"}
    else
      render "edit"
    end
  end


  private


  def user_account_params
    params.require(:user_account).permit(:password, :password_confirmation, :reset_password_token, :current_password)
  end

  def set_user
    @user = User.find(current_user.id)
    @user_account = current_admin_user_account
  end

  # Only allow a list of trusted parameters through.
  def admin_user_params
    params.require(:user)
          .permit(:firstname, :lastname, :email, :phone, :role, :phone_number)
  end

  def create_user_account(user)
    admin_user_account = get_admin_user_account_object(user.email, user.id)

    if admin_user_account.save
      AdminUserMailer.send_admin_user_creation_email(admin_user_account.email, admin_user_account.password).deliver_later
    end
  end

  def get_admin_user_account_object(email, user_id)
    generated_password = Devise.friendly_token.first(8)
    encrypted_password =  BCrypt::Password.create(generated_password)

    admin_user_account = UserAccount.new(
      user_id: user_id,
      password: generated_password,
      email: email,
      encrypted_password: encrypted_password
    )

    admin_user_account
  end
end
