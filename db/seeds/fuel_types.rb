puts "Creating fuel types ..."

seed_file = Rails.root.join('db', 'fixtures', 'fuel_types.yml')
fuel_types = YAML::load_file(seed_file)

FuelType.create!(fuel_types) do |c|
  print '.'
end

puts "ok"
puts "Fuel types created."
