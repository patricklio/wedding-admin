class Admin::OperationsController < ApplicationController
  def index
    @operations = Operation.include_joboperations_counts
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
