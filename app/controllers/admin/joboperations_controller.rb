class Admin::JoboperationsController < ApplicationController
  before_action :set_joboperation, only: [:edit, :update, :destroy]
  before_action :set_new_joboperation, only: [:new]

  def index
    @joboperations = Joboperation.all
  end

  def new

  end

  def create
    # respond_to do |f|
      operation = Operation.find_by(id: jo_params[:operation_id])
      if operation.nil?
        # Create operation if doesn't exists
        operation = Operation.new(name: jo_params[:operation_id], description: jo_params[:operation_id])
        operation.save
      end

      joboperation = Joboperation.new(operation_id: operation.id, repairoption_id: jo_params[:repairoption_id])
      if joboperation.save
        if params[:commit] == "Enregistrer"
          redirect_to admin_repairoptions_path, flash: { success: "Les données ont bien été enregistrées." }
        else
          redirect_to edit_admin_repairoption_path(joboperation.repairoption), flash: { success: "Les données ont bien été enregistrées." }
        end
      else

        redirect_to edit_admin_repairoption_path(joboperation.repairoption), flash: { error: joboperation.errors.full_messages.to_sentence }
      end
  end

  def edit

  end

  def update
    if @joboperation.update(jo_params)
      if params[:commit] == "Enregistrer"
        redirect_to admin_joboperations_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_joboperation_path(@joboperation), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      render :edit
    end
  end

  def destroy
    @joboperation.destroy

    redirect_to edit_admin_repairoption_path(@joboperation.repairoption), flash: { success: "Les données ont bien été supprimées." }
  end

  private

  def set_new_joboperation
    @joboperation = Joboperation.new
  end

  def set_joboperation
    @joboperation = Joboperation.find(params[:id])
    @jobparts = @joboperation.jobparts
    @jobpart = Jobpart.new
  end

  def set_new_operation
  end

  def jo_params
    params.require(:joboperation).permit(:operation_id, :repairoption_id)
  end
end
