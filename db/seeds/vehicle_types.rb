puts "Creating vehicle_types ..."

seed_file = Rails.root.join('db', 'fixtures', 'vehicle_types.yml')
vehicle_types = YAML::load_file(seed_file)

vehicle_types.each do |c|
  vehicle_type = {
    "name" => c["name"]
  }

  VehicleType.create!(vehicle_type)

  print '.'
end

puts "ok"
puts "Vehicle types created."
