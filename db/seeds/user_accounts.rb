puts "Creating user accounts ..."

seed_file = Rails.root.join('db', 'fixtures', 'user_accounts.yml')
user_accounts = YAML::load_file(seed_file)

user_accounts.each do |c|
  user_account = {
    "email" => c["email"],
    "password" => c["password"]
  }
  customer = Customer.find_by_company_name(c["customer"])
  user_account["customer"] = customer

  UserAccount.create!(user_account)

  print '.'
end

puts "ok"
puts "User accounts created."
