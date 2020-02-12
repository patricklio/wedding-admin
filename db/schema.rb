# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_09_204754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointment_mechanics", force: :cascade do |t|
    t.bigint "appointment_id", null: false
    t.bigint "partner_user_id", null: false
    t.boolean "lead_mechanic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appointment_id"], name: "index_appointment_mechanics_on_appointment_id"
    t.index ["partner_user_id"], name: "index_appointment_mechanics_on_partner_user_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "appointment_time"
    t.text "comments"
    t.string "status"
    t.decimal "review_rate"
    t.text "review_comments"
    t.bigint "workorder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workorder_id"], name: "index_appointments_on_workorder_id"
  end

  create_table "category_attributes", force: :cascade do |t|
    t.bigint "model_id", null: false
    t.bigint "fuel_type_id", null: false
    t.bigint "vehicle_category_id", null: false
    t.integer "vehicle_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fuel_type_id"], name: "index_category_attributes_on_fuel_type_id"
    t.index ["model_id"], name: "index_category_attributes_on_model_id"
    t.index ["vehicle_category_id"], name: "index_category_attributes_on_vehicle_category_id"
  end

  create_table "customer_notifications", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "mark_as_read"
    t.bigint "user_account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_account_id"], name: "index_customer_notifications_on_user_account_id"
  end

  create_table "customer_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "company_name"
    t.text "address"
    t.string "phone_number"
    t.string "ninea"
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_type_id", null: false
    t.index ["customer_type_id"], name: "index_customers_on_customer_type_id"
  end

  create_table "fuel_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "info_requests", force: :cascade do |t|
    t.string "company_name"
    t.string "firstname"
    t.string "lastname"
    t.text "company_address"
    t.string "working_email"
    t.string "phone_number"
    t.string "ninea"
    t.text "comments"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "intervention_report_lines", force: :cascade do |t|
    t.bigint "intervention_report_id", null: false
    t.bigint "jobpart_id", null: false
    t.string "part_reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["intervention_report_id"], name: "index_intervention_report_lines_on_intervention_report_id"
    t.index ["jobpart_id"], name: "index_intervention_report_lines_on_jobpart_id"
  end

  create_table "intervention_reports", force: :cascade do |t|
    t.bigint "appointment_id", null: false
    t.bigint "partner_user_id", null: false
    t.decimal "vehicle_mileage"
    t.date "intervention_date"
    t.text "comments"
    t.decimal "next_mileage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appointment_id"], name: "index_intervention_reports_on_appointment_id"
    t.index ["partner_user_id"], name: "index_intervention_reports_on_partner_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "reference"
    t.date "creation_date"
    t.string "status"
    t.text "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "joboperations", force: :cascade do |t|
    t.decimal "labor"
    t.bigint "operation_id", null: false
    t.bigint "repairoption_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["operation_id"], name: "index_joboperations_on_operation_id"
    t.index ["repairoption_id"], name: "index_joboperations_on_repairoption_id"
  end

  create_table "jobparts", force: :cascade do |t|
    t.bigint "part_id", null: false
    t.bigint "joboperation_id"
    t.bigint "repairoption_id"
    t.integer "part_qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["joboperation_id"], name: "index_jobparts_on_joboperation_id"
    t.index ["part_id"], name: "index_jobparts_on_part_id"
    t.index ["repairoption_id"], name: "index_jobparts_on_repairoption_id"
  end

  create_table "makes", force: :cascade do |t|
    t.string "name"
    t.text "logo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.bigint "make_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["make_id"], name: "index_models_on_make_id"
  end

  create_table "operations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "part_prices", force: :cascade do |t|
    t.bigint "part_id", null: false
    t.decimal "part_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vehicle_category_id", null: false
    t.index ["part_id"], name: "index_part_prices_on_part_id"
    t.index ["vehicle_category_id"], name: "index_part_prices_on_vehicle_category_id"
  end

  create_table "partner_notifications", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "mark_as_read"
    t.bigint "partner_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_user_id"], name: "index_partner_notifications_on_partner_user_id"
  end

  create_table "partner_repairoptions", force: :cascade do |t|
    t.bigint "partner_id", null: false
    t.bigint "repairoption_id", null: false
    t.decimal "labor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_id"], name: "index_partner_repairoptions_on_partner_id"
    t.index ["repairoption_id"], name: "index_partner_repairoptions_on_repairoption_id"
  end

  create_table "partner_users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email", default: "", null: false
    t.string "phone_number"
    t.string "role"
    t.string "firstname"
    t.string "lastname"
    t.bigint "partner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_partner_users_on_email", unique: true
    t.index ["partner_id"], name: "index_partner_users_on_partner_id"
    t.index ["reset_password_token"], name: "index_partner_users_on_reset_password_token", unique: true
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "email"
    t.decimal "labor_hour_price"
    t.string "labor_currency"
    t.decimal "margin_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parts", force: :cascade do |t|
    t.string "part_desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.string "status"
    t.date "payment_date"
    t.string "payment_type"
    t.string "payment_reference"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "repairoption_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "repairoptions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "propose_in_option"
    t.decimal "labor"
    t.bigint "repairoption_category_id", null: false
    t.bigint "partner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_id"], name: "index_repairoptions_on_partner_id"
    t.index ["repairoption_category_id"], name: "index_repairoptions_on_repairoption_category_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.bigint "customer_id", null: false
    t.bigint "info_request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["customer_id"], name: "index_user_accounts_on_customer_id"
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["info_request_id"], name: "index_user_accounts_on_info_request_id"
    t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true
  end

  create_table "user_sessions", force: :cascade do |t|
    t.string "ip_address"
    t.datetime "start_time"
    t.datetime "expired_time"
    t.bigint "user_account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_account_id"], name: "index_user_sessions_on_user_account_id"
  end

  create_table "vehicle_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "partner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_id"], name: "index_vehicle_categories_on_partner_id"
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "VIN"
    t.string "license_plate"
    t.integer "doors_number"
    t.integer "seats_number"
    t.decimal "mileage"
    t.date "purchase_date"
    t.string "engine"
    t.decimal "power"
    t.integer "year"
    t.bigint "customer_id", null: false
    t.bigint "fuel_type_id", null: false
    t.bigint "model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vehicle_type_id", null: false
    t.index ["customer_id"], name: "index_vehicles_on_customer_id"
    t.index ["fuel_type_id"], name: "index_vehicles_on_fuel_type_id"
    t.index ["model_id"], name: "index_vehicles_on_model_id"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
  end

  create_table "workorder_items", force: :cascade do |t|
    t.bigint "workorder_id", null: false
    t.bigint "repairoption_id", null: false
    t.money "reduction_amount", scale: 2
    t.integer "quantity"
    t.decimal "tax_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["repairoption_id"], name: "index_workorder_items_on_repairoption_id"
    t.index ["workorder_id"], name: "index_workorder_items_on_workorder_id"
  end

  create_table "workorders", force: :cascade do |t|
    t.string "number"
    t.text "address"
    t.string "status"
    t.decimal "total_price"
    t.date "workorder_date"
    t.string "currency"
    t.bigint "vehicle_id", null: false
    t.bigint "invoice_id"
    t.bigint "user_account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "total_part_price"
    t.index ["invoice_id"], name: "index_workorders_on_invoice_id"
    t.index ["user_account_id"], name: "index_workorders_on_user_account_id"
    t.index ["vehicle_id"], name: "index_workorders_on_vehicle_id"
  end

  add_foreign_key "appointment_mechanics", "appointments"
  add_foreign_key "appointment_mechanics", "partner_users"
  add_foreign_key "appointments", "workorders"
  add_foreign_key "category_attributes", "fuel_types"
  add_foreign_key "category_attributes", "models"
  add_foreign_key "category_attributes", "vehicle_categories"
  add_foreign_key "customer_notifications", "user_accounts"
  add_foreign_key "customers", "customer_types"
  add_foreign_key "intervention_report_lines", "intervention_reports"
  add_foreign_key "intervention_report_lines", "jobparts"
  add_foreign_key "intervention_reports", "appointments"
  add_foreign_key "intervention_reports", "partner_users"
  add_foreign_key "joboperations", "operations"
  add_foreign_key "joboperations", "repairoptions"
  add_foreign_key "jobparts", "joboperations"
  add_foreign_key "jobparts", "parts"
  add_foreign_key "jobparts", "repairoptions"
  add_foreign_key "models", "makes"
  add_foreign_key "part_prices", "parts"
  add_foreign_key "part_prices", "vehicle_categories"
  add_foreign_key "partner_notifications", "partner_users"
  add_foreign_key "partner_repairoptions", "partners"
  add_foreign_key "partner_repairoptions", "repairoptions"
  add_foreign_key "partner_users", "partners"
  add_foreign_key "payments", "invoices"
  add_foreign_key "repairoptions", "partners"
  add_foreign_key "repairoptions", "repairoption_categories"
  add_foreign_key "user_accounts", "customers"
  add_foreign_key "user_accounts", "info_requests"
  add_foreign_key "user_sessions", "user_accounts"
  add_foreign_key "vehicle_categories", "partners"
  add_foreign_key "vehicles", "customers"
  add_foreign_key "vehicles", "fuel_types"
  add_foreign_key "vehicles", "models"
  add_foreign_key "vehicles", "vehicle_types"
  add_foreign_key "workorder_items", "repairoptions"
  add_foreign_key "workorder_items", "workorders"
  add_foreign_key "workorders", "invoices"
  add_foreign_key "workorders", "user_accounts"
  add_foreign_key "workorders", "vehicles"
end
