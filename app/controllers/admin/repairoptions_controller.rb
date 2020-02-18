class Admin::RepairoptionsController < ApplicationController
  before_action :set_repairoption, only: [:edit, :update]
  before_action :set_new_repairoption, only: [:new]

  def index
    @repairoptions = Repairoption.all.order('updated_at DESC')
  end


  def new
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

  def edit
    @joboperations = @repairoption.joboperations
  end

  def destroy
  end



  def show
  end


  private
  def set_new_repairoption
    @repairoption = Repairoption.new
  end

  def set_repairoption
    @repairoption = Repairoption.find(params[:id])
    @joboperation = Joboperation.new
  end

  def ro_params
    params.require(:repairoption).permit(:name, :description, :repairoption_category_id, :optional)
  end

end
