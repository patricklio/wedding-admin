puts "Creating repairoption categories ..."

seed_file = Rails.root.join('db', 'fixtures', 'repairoption_categories.yml')
repairoption_categories = YAML::load_file(seed_file)

RepairoptionCategory.create!(repairoption_categories) do |c|
  print '.'
end

puts "ok"
puts "Repairoption categories created."
