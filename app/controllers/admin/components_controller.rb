class Admin::ComponentsController < ApplicationController
  def index
    @make = Make.all
    puts ' ----make----'
    puts @make
    @model = Model.all
    @fuelType = FuelType.all
    @vehicleType = VehicleType.all
    @categories = RepairoptionCategory.all
  end
end
