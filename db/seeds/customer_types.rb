puts "Creating customer types ..."

seed_file = Rails.root.join('db', 'fixtures', 'customer_types.yml')
customer_types = YAML::load_file(seed_file)

CustomerType.create!(customer_types) do |c|
  print '.'
end

puts "ok"
puts "Customer types created."
