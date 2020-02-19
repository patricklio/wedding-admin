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
        redirect_to admin_users_path, flash: { success: "Les données ont bien été modifiées."}
      else
        redirect_to edit_admin_user_path(@user), flash: { success: "Les données ont bien été modifiées."}
      end
    else
      render :edit
    end
  end

  # PATCH  /admin/update_password
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


  def user_account_params
    params.require(:user_account).permit(:password, :password_confirmation)
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
    encrypted_password = BCrypt::Password.create("password")

    UserAccount.create!(user_id: user.id,
                        password: "password",
                        email: user.email,
                        encrypted_password: encrypted_password
                      )
  end
end
