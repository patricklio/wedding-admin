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
      redirect_to admin_partners_path, flash: { success: "Les données ont bien été enregistrées." }
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    if @partner.update(partner_params)
      redirect_to admin_partners_path, flash: { success: "Les données ont bien été mises à jour." }
    else
      render :edit
    end
  end

  def destroy
    @partner.destroy

    redirect_to admin_partners_path
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
end
