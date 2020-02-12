puts "Creating partners ..."

seed_file = Rails.root.join('db', 'fixtures', 'partners.yml')
partners = YAML::load_file(seed_file)

partners.each do |c|
  partner = Partner.new(c)
  partner.save

  print '.'
end

puts "ok"
puts "Partners created."
