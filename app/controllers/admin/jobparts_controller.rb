class Admin::JobpartsController < ApplicationController
  before_action :set_jobpart, only: [:edit, :update, :destroy]
  before_action :set_new_jobpart, only: [:new]

  def index
    @jobparts = Jobpart.include_part_desc_joboperation_name
  end

  def new

  end

  def create
    part = Part.find_by(id: jobpart_params[:part_id])
    if part.nil?
      # Create part if doesn't exists
      part = Part.new(part_desc: jobpart_params[:part_id].upcase)
      part.save
    end

    jobpart = Jobpart.new(part_id: part.id, part_qty: jobpart_params[:part_qty], joboperation_id: jobpart_params[:joboperation_id])

    if jobpart.save
      if params[:commit] == "Enregistrer"
        redirect_to admin_joboperations_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_joboperation_path(jobpart.joboperation), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      redirect_to edit_admin_joboperation_path(jobpart.joboperation), flash: { error: jobpart.errors.full_messages.to_sentence }
    end
  end

  def edit

  end

  def update
    if @jobpart.update(jobpart_params)
      if params[:commit] == "Enregistrer"
        redirect_to admin_jobparts_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_jobpart_path(@jobpart), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      render :edit
    end
  end

  def destroy
    @jobpart.destroy

    redirect_to edit_admin_joboperation_path(@jobpart.joboperation), flash: { success: "Les données ont bien été supprimées." }
  end

  private

  def set_new_jobpart
    @jobpart = Jobpart.new
  end

  def set_jobpart
    @jobpart = Jobpart.find(params[:id])
  end

  def set_new_part
  end

  def jobpart_params
    params.require(:jobpart).permit(:part_id, :part_qty, :joboperation_id)
  end
end
