class Admin::RepairoptionsController < ApplicationController
  before_action :set_repairoption, only: [:edit, :update]

  def index
    @repairoptions = Repairoption.includes(:repairoption_category).order('updated_at DESC')

    respond_to do |format|
      format.html
      format.json {
        render json: {repairoptions: @repairoptions}
      }
    end
  end

  def categories
    @categories = Repairoption.preload(:repairoption_category).map{|r| r.repairoption_category.name}.flatten

    respond_to do |format|
      format.json {
        render json: {categories: @categories}
      }
    end
  end

  def new
    @repairoption = Repairoption.new
  end

  def create
    @repairoption = Repairoption.new(ro_params)

    if @repairoption.save
      if params[:commit] == "Enregistrer"
        redirect_to admin_repairoptions_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_repairoption_path(@repairoption), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      render :new
    end
  end

  def edit
    @joboperations = Repairoption.include_operation_name.where(id: @repairoption.id)
  end

  def update
    if @repairoption.update(ro_params)
      if params[:commit] == "Enregistrer"
        redirect_to admin_repairoptions_path, flash: { success: "Les données ont bien été mises à jour." }
      else
        redirect_to edit_admin_repairoption_path(@repairoption), flash: { success: "Les données ont bien été mises à jour." }
      end
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_repairoption
    @repairoption = Repairoption.find(params[:id])
    @joboperations = @repairoption.joboperations
    @joboperation = Joboperation.new
  end

  def ro_params
    params.require(:repairoption).permit(:name, :description, :repairoption_category_id, :optional)
  end
end
