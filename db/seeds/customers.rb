puts "Creating customers ..."

seed_file = Rails.root.join('db', 'fixtures', 'customers.yml')
customers = YAML::load_file(seed_file)

customers.each do |c|
  customer = {
    "company_name" => c["company_name"],
    "firstname" => c["firstname"],
    "lastname" => c["lastname"],
    "address" => c["address"],
    "email" => c["email"],
    "phone_number" => c["phone_number"],
    "ninea" => c["ninea"]
  }
  customer_type = CustomerType.find_by_name(c[customer_type])
  unless customer_type
    customer_type = CustomerType.create!(c[customer_type])
  end
  customer["customer_type"] = customer_type

  Customer.create!(customer)

  print '.'
end

puts "ok"
puts "Customers created."
