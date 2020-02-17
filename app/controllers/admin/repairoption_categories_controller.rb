class Admin::RepairoptionCategoriesController < ApplicationController
  before_action :set_repairoption_category, only: [:destroy, :edit]
  def index
    @categories = RepairoptionCategory.all
  end

  def destroy
    @category.destroy

    redirect_to admin_repairoption_categories_path
  end

  def new
    @repairoption_category = RepairoptionCategory.new
  end

  def create
    @repairoption_category = RepairoptionCategory.new(repairoption_category_params)

    if @repairoption_category.save
      success_message = "Les données ont bien été enregistrées."

      if params[:commit] == "Enregistrer"
        redirect_to admin_repairoption_categories_path, flash: { success: success_message }
      else
        redirect_to edit_admin_repairoption_category_path(@repairoption_category), flash: { success: success_message }
      end
    else
      render :new
    end
  end

  def edit
  end

  private

  def set_repairoption_category
    @category = RepairoptionCategory.find(params[:id])
  end

  def repairoption_category_params
    params.require(:repairoption_category).permit(:name, :description)
  end
end
