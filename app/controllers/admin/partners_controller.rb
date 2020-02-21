class Admin::PartnersController < ApplicationController
  before_action :set_edit_partner, only: [:destroy, :edit, :update, :show]

  def index
    @partners = Partner.all
  end

  def new
    set_new_partner
  end

  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      create_default_partner_user_account(@partner)

      if params[:commit] == "Enregistrer"
        redirect_to admin_partners_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_partner_path(@partner), flash: { success: "Les données ont bien été modifiées."}
      end

    else
      render :new
    end
  end

  def show
    @partner_user_accounts = @partner.partner_user_accounts
  end

  def edit
  end

  def update
    if @partner.update(partner_params)
      if params[:commit] == "Enregistrer"
        redirect_to admin_partners_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_partner_path(@partner), flash: { success: "Les données ont bien été modifiées."}
      end
    else
      render :edit
    end
  end

  def destroy
    @partner.destroy

    redirect_to admin_partners_path
  end

  def add_partner_user_account
    partner_account = get_partner_account_object(params[:partner_user_account][:email],
                                                  params[:partner_user_account][:partner_id],
                                                  "",
                                                  "",
                                                  params[:partner_user_account][:role])
    password = partner_account.password
    if partner_account.save
      PartnerMailer.send_partner_creation_email(partner_account.email, password).deliver_later if partner_account
      if params[:commit] == "Enregistrer"
        redirect_to admin_partners_path, flash: { success: "Les données ont bien été modifiées."}
      else
        redirect_to edit_admin_partner_path(partner_account.partner), flash: { success: "Les données ont bien été modifiées."}
      end
    else
      redirect_to edit_admin_partner_path(partner_account.partner), flash: { error: partner_account.errors.full_messages.to_sentence }
    end
  end

  private

  def set_edit_partner
    @partner = Partner.find(params[:id])
    @partner_user_accounts = @partner.partner_user_accounts
  end

  def set_new_partner
    @partner = Partner.new
  end

  def partner_params
    params.require(:partner).permit(:name, :address, :phone_number, :email, :labor_hour_price, :labor_currency)
  end

  def partner_user_account_params
    params.require(:partner_user_account).permit(:email, :role, :partner_id)
  end


  def create_default_partner_user_account(partner)
    generated_password = Devise.friendly_token.first(8)
    encrypted_password =  BCrypt::Password.create(generated_password)

    new_partner_account = get_partner_account_object(partner.email, partner.id, partner.name, partner.name, default_user_account_role)

    if new_partner_account.save
      PartnerMailer.send_partner_creation_email(new_partner_account.email, generated_password).deliver_later
    end
  end

  def get_partner_account_object(email, partner_id, firstname, lastname, role)
    generated_password = Devise.friendly_token.first(8)
    encrypted_password =  BCrypt::Password.create(generated_password)

    new_partner_account = PartnerUserAccount.new(
      partner_id: partner_id,
      password: generated_password,
      email: email,
      role: role,
      encrypted_password: encrypted_password
    )

    new_partner_account
  end

  def default_user_account_role
    "admin"
  end
end
