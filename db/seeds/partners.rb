puts "Creating partners ..."

seed_file = Rails.root.join('db', 'fixtures', 'partners.yml')
partners = YAML::load_file(seed_file)

Partner.create!(partners) do |c|
  print '.'
end

puts "ok"
puts "Partners created."
