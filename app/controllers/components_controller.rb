class ComponentsController < ApplicationController
  def index
    @make = Make.all
    @model = Model.all
    @fuelType = FuelType.all
    @vehicleType = VehicleType.all
    @categories = RepairoptionCategory.all
  end
end
