class Admin::RepairoptionsController < ApplicationController

  def index
    @repairoptions = Repairoption.includes(:repairoption_category)
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
  end
end
