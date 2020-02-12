puts "Creating operations ..."

seed_file = Rails.root.join('db', 'fixtures', 'operations.yml')
operations = YAML::load_file(seed_file)

Operation.create!(operations) do |c|
  print '.'
end

puts "ok"
puts "Operations created."
