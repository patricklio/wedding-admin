# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Clean database
puts "Cleaning database..."

UserAccount.delete_all
User.delete_all


# # CREATE PARTNERS
# load Rails.root.join("db/seeds/partners.rb")

# # CREATE MAKES
# load Rails.root.join("db/seeds/makes.rb")

# # CREATE MODELS
# load Rails.root.join("db/seeds/models.rb")

# # CREATE FUEL_TYPES
# load Rails.root.join("db/seeds/fuel_types.rb")

# # CREATE CUSTOMER_TYPES
# load Rails.root.join("db/seeds/customer_types.rb")

# # CREATE VEHICLE_TYPES
# load Rails.root.join("db/seeds/vehicle_types.rb")

# # CREATE PARTS
# load Rails.root.join("db/seeds/parts.rb")

# # CREATE OPERATIONS
# load Rails.root.join("db/seeds/operations.rb")

# # CREATE REPAIROPTION CATEGORIES
# load Rails.root.join("db/seeds/repairoption_categories.rb")

# CREATE USERS
load Rails.root.join("db/seeds/users.rb")
