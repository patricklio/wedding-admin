class Admin::OperationsController < ApplicationController
  before_action :set_operation, only: [:destroy, :edit, :update]

  def index
    @operations = Operation.include_joboperations_counts
  end

  def new
    @operation = Operation.new
  end

  def create
    @operation = Operation.new(operation_params)

    if @operation.save

      if params[:commit] == "Enregistrer"
        redirect_to admin_operations_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_operation_path(@operation), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @operation.update(operation_params)
      if params[:commit] == "Enregistrer"
        redirect_to admin_operations_path, flash: { success: "Les données ont bien été enregistrées." }
      else
        redirect_to edit_admin_operation_path(@operation), flash: { success: "Les données ont bien été enregistrées." }
      end
    else
      render :edit
    end
  end

  def destroy
    @operation.destroy

    redirect_to admin_operations_path
  end

  private

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:name, :description)
  end
end
