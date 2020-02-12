puts "Creating vehicules categories ..."

seed_file = Rails.root.join('db', 'fixtures', 'vehicule_categories.yml')
categories = YAML::load_file(seed_file)

partner = Partner.first

categories.each do |category|
  category = {
    "name" => category["name"],
    "description" => category["description"],
    partner: partner
  }

  VehicleCategory.create!(category)

  puts '.'
end

puts "ok"
puts "Vehicule categories created successfully."
