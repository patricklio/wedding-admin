puts "Creating parts ..."

seed_file = Rails.root.join('db', 'fixtures', 'parts.yml')
parts = YAML::load_file(seed_file)

Part.create!(parts) do |c|
  print '.'
end

puts "ok"
puts "Parts created."
