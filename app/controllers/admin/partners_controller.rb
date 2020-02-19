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
      create_defaut_partner_user_account(@partner)

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
    @partner_user_account = PartnerUserAccount.new
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
    @partner_account = PartnerUserAccount.new(partner_user_account_params)

    if create_partner_user_account(@partner_account)

      if params[:commit] == "Enregistrer"
        redirect_to admin_partners_path, flash: { success: "Les données ont bien été modifiées."}
      else
        redirect_to edit_admin_partner_path(@partner_account.partner), flash: { success: "Les données ont bien été modifiées."}
      end
    else
      redirect_to edit_admin_partner_path(@partner_account.partner), flash: { error: @partner_account.errors.full_messages.to_sentence }
    end
  end

  private

  def set_edit_partner
    @partner = Partner.find(params[:id])
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

  def create_defaut_partner_user_account(partner)
    generated_password = Devise.friendly_token.first(8)
    encrypted_password = BCrypt::Password.create(generated_password)

    PartnerUserAccount.create!(partner_id: partner.id,
                        password: "password",
                        email: partner.email,
                        role: "admin",
                        encrypted_password: encrypted_password
                      )
                      puts '---partner default----'
                      puts partner.as_json.pretty_inspect
    PartnerMailer.send_partner_creation_email(partner, generated_password).deliver_later
  end

  def create_partner_user_account(partner_account)
    generated_password = Devise.friendly_token.first(8)
    encrypted_password =  BCrypt::Password.create(generated_password)

    new_partner_account = PartnerUserAccount.create!(
      partner_id: partner_account.partner_id,
      password: generated_password,
      email: partner_account.email,
      role: partner_account.role,
      encrypted_password: encrypted_password)

      puts '---partner----'
      puts partner_account.as_json.pretty_inspect

      PartnerMailer.send_partner_creation_email(partner_account, generated_password).deliver_later
  end
end
