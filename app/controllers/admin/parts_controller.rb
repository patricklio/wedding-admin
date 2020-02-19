class Admin::PartsController < ApplicationController
  before_action :set_part, only: [:destroy, :edit, :update]

  def index
    @parts = Part.include_jobparts_counts
  end

  def new
    @part = Part.new
  end

  def create
    @part = Part.new(part_params)

    if @part.save

      if params[:commit] == "Enregistrer"
        redirect_to admin_parts_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_part_path(@part), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @part.update(part_params)
      if params[:commit] == "Enregistrer"
        redirect_to admin_parts_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_part_path(@part), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      render :edit
    end
  end

  def destroy
    @part.destroy

    redirect_to admin_parts_path
  end

  private

  def set_part
    @part = Part.find(params[:id])
  end

  def part_params
    params.require(:part).permit(:part_desc)
  end
end
