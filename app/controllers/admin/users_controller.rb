class Admin::UsersController < ApplicationController
  # before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    @users = User.all
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(admin_user_params)

    respond_to do |format|
      if @user.save
        create_user_account(@user)

        format.html { redirect_to admin_users_path, notice: "l' utilisateur est créé avec succès." }
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
  private

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.require(:user)
            .permit(:firstname, :lastname, :email, :phone, :role, :phone_number)
    end

    def create_user_account(user)
      encrypted_password = BCrypt::Password.create(params[:user][:password])

      UserAccount.create!(user_id: user.id,
                          email: user.email,
                          encrypted_password: encrypted_password
                        )
    end
end
