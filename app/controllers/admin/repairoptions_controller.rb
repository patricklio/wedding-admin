class Admin::RepairoptionsController < ApplicationController

  def index
    # @repairoptions = Repairoption.all
    @repairoptions = Repairoption.includes(:repairoption_category)
  end

  def new
  end
end
