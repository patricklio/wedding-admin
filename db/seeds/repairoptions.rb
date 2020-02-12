puts "Creating repairoptions, jobparts and joboperations ..."

seed_file = Rails.root.join('db', 'fixtures', 'repairoptions.yml')
repairoptions = YAML::load_file(seed_file)

partner = Partner.first

repairoptions.each do |c|
  category = RepairoptionCategory.find_by_name(c["category"])

  repairoption = {
    name: c["name"],
    description: c["description"],
    propose_in_option: c["propose_in_option"],
    labor: c["labor"],
    repairoption_category: category,
    partner: partner
  }
  ro = Repairoption.create!(repairoption)

  joboperations = c["joboperations"]
  if joboperations
    joboperations.each do |jo|
      operation = Operation.find_by_name(jo["operation"])

      job_param = {
        labor: jo["labor"],
        repairoption: ro,
        operation: operation
      }

      job = Joboperation.create!(job_param)

      jobparts = jo["jobparts"]
      if jobparts
        jobparts.each do |jp|
          part = Part.find_by_part_desc(jp["part"])

          jobpart_param = {
            part_qty: jp["qty"],
            joboperation_id: job.id,
            part: part
          }

          Jobpart.create!(jobpart_param)
        end
      end
    end
  end


  print '.'
end

puts "ok"
puts "Repairoptions, jobparts and joboperations created."
