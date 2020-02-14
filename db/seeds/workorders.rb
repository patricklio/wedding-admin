require 'date'
puts "Creating workorders ..."

seed_file = Rails.root.join('db', 'fixtures', 'workorders.yml')
workorders = YAML::load_file(seed_file)

workorders.each do |c|
  vehicle = Vehicle.find_by_VIN(c["vehicle_vin"])
  user_account = UserAccount.find_by_email(c["user_account_email"])

  workorder = {
    number: c["number"],
    address: c["address"],
    status: c["status"],
    total_price: c["total_price"],
    currency: c["currency"],
    workorder_date: Date.today,
    vehicle: vehicle,
    user_account: user_account
  }
  wo = Workorder.create!(workorder)

  items = c["items"]
  if items
    items.each do |item|
      repairoption = Repairoption.find_by_name(item["repairoption"])

      item_param = {
        quantity: item["qty"],
        tax_rate: item["tax_rate"],
        repairoption: repairoption,
        workorder: wo
      }

      WorkorderItem.create!(item_param)
    end
  end

  print '.'
end

puts "ok"
puts "Workorders created."
