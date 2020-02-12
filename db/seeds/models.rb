puts "Creating models..."

seed_file = Rails.root.join('db', 'fixtures', 'models.yml')
config = YAML::load_file(seed_file)

config.each do |m, models|
  make = Make.find_by_name(m)
  unless make
    make = Make.create!(m)
  end

  models.each do |c|
    model = {
      name: c["name"],
      make: make
    }

    Model.create!(model)
    print "."
  end
end

puts "ok"
puts "models created."
