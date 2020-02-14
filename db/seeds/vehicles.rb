puts "Creating vehicles ..."

seed_file = Rails.root.join('db', 'fixtures', 'vehicles.yml')
vehicles = YAML::load_file(seed_file)

vehicles.each do |c|
  model = Model.find_by_name(c["model"])
  vehicle_type = VehicleType.find_by_name(c["vehicle_type"])
  customer = Customer.find_by_company_name(c["customer"])
  fuel_type = FuelType.find_by_name(c["fuel_type"])
  unless fuel_type
    fuel_type = FuelType.create!(c["fuel_type"])
  end

  vehicle = {
    VIN: c["vin"],
    license_plate: c["license_plate"],
    doors_number: c["doors_number"],
    seats_number: c["seats_number"],
    mileage: c["mileage"],
    engine: c["engine"],
    power: c["power"],
    year: c["year"],
    model: model,
    customer: customer,
    fuel_type: fuel_type,
    vehicle_type: vehicle_type
  }

  Vehicle.create!(vehicle)

  print '.'
end

puts "ok"
puts "vehicles created."
