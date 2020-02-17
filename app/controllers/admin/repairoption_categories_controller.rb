class Admin::RepairoptionCategoriesController < ApplicationController
  before_action :set_repairoption_category, only: [:destroy]
  def index
    @categories = RepairoptionCategory.all
  end

  def destroy
    @category.destroy

    redirect_to admin_repairoption_categories_path
  end

  private

  def set_repairoption_category
    @category = RepairoptionCategory.find(params[:id])
  end
end
