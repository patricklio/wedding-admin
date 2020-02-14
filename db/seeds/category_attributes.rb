puts "Creating category attributes ..."

seed_file = Rails.root.join('db', 'fixtures', 'category_attributes.yml')
attributes = YAML::load_file(seed_file)

attributes.each do |attribute|
  model = Model.find_by_name(attribute["model"])
  fuel_type = FuelType.find_by_name(attribute["fuel_type"])
  category = VehicleCategory.find_by_name(attribute["category"])

  attribute = {
    model: model,
    fuel_type: fuel_type,
    vehicle_year: attribute["vehicle_year"],
    vehicle_category: category
  }

  CategoryAttribute.create!(attribute)

  puts '.'
end

puts "ok"
puts "Category attributes created successfully."
