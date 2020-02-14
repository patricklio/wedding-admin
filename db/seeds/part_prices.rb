puts "Creating Part_prices ..."

seed_file = Rails.root.join('db', 'fixtures', 'part_prices.yml')
part_prices = YAML::load_file(seed_file)

part_prices.each do |pp|
  category = VehicleCategory.find_by_name(pp['category'])
  part = Part.find_by(part_desc: pp['part'])

  part_price = {
    part: part,
    vehicle_category: category,
    part_price: pp['part_price']
  }

  PartPrice.create!(part_price)

  print '.'
end

puts 'ok'
puts 'part_prices created.'
