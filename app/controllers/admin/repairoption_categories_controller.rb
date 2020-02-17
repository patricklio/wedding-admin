class Admin::RepairoptionCategoriesController < ApplicationController
  def index
    @categories = RepairoptionCategory.all
  end

  def destroy
  end
end
