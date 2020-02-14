puts "Creating partner users ..."

seed_file = Rails.root.join('db', 'fixtures', 'partner_users.yml')
partner_users = YAML::load_file(seed_file)

partner_users.each do |c|
  partner_user = {
    "username" => c["email"],
    "password" => c["password"],
    "phone_number" => c["phone_number"],
    "email" => c["email"],
    "role" => c["role"],
    "firstname" => c["firstname"],
    "lastname" => c["lastname"]
  }
  partner = Partner.find_by_name(c["partner"])
  partner_user["partner"] = partner

  PartnerUserAccount.create!(partner_user)

  print '.'
end

puts "ok"
puts "Partner users created."
