require "csv"

puts "Creating makes ..."

makes = []
make_csv_file = Rails.root.join("db/fixtures/makes.csv")
csv_options = { headers: :first_row, header_converters: :symbol }

CSV.foreach(make_csv_file, csv_options) do |row|
  name = row[:name].strip

  makes << Make.new(name: name)

  Make.import! makes, validate: true, validate_uniqueness: true
  makes = []
  print '.'
end

puts "ok"
puts "Makes created."
