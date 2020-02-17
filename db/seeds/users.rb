require 'bcrypt'

puts "Creating user and user accounts ..."

seed_file = Rails.root.join('db', 'fixtures', 'users.yml')
users = YAML::load_file(seed_file)

users.each do |c|
  user = {
    "email" => c["email"],
    "firstname" => c["firstname"],
    "lastname" => c["lastname"],
    "phone_number" => c["phone_number"],
    "role" => c["role"],
  }

  my_user = User.create!(user)

  encrypted_password = BCrypt::Password.create(c["password"])
  UserAccount.create!(user_id: my_user.id, email: c["email"], encrypted_password: encrypted_password, password: c["password"])

  print '.'
end

puts "ok"
puts "Users and accounts created."
