require_relative "../helpers/xml_to_json_helper"
include XmlToJsonHelper
require_relative "./uclassify"
# include Uclassify
require_relative "../helpers/get_bill_text_from_summary_helper"
require_relative "../helpers/category_mapper_helper"

require "pry"

#=========

#======

CLASSIFIER_NAME = "Commons_api"

continue_file = __dir__ + "/continue_training_summary_bills.json"

if (File.exists?(continue_file))
  input_file = continue_file
else
  input_file = __dir__ + "/legislative_summary_bills.json"
end

bills = JSON.parse(File.read(input_file))
# bills_copy = bills

while bills.size > 0
  bill = bills.shift

  pp bill["title"]

  if bill["category"].nil?
    next
  end

  if bill["category"].kind_of?(String)
    bill["category"] = [bill["category"]]
  end

  unless bill["category"].include?("Education, language and training")
    # puts "- no category for arts: #{bill["category"]}"
    next
  end

  # binding.pry

  text = GetBillTextFromSummaryHelper::get_text(bill)

  # binding.pry
  if text.empty?
    next
  end

  error = false

  while bill["category"].size > 0
    cat = bill["category"].shift
    pp "-- #{cat}"

    begin
      res = Uclassify::train(text, CLASSIFIER_NAME, CategoryMapperHelper::map(cat))
      error = res.status != 200
    rescue Net::ReadTimeout, Faraday::TimeoutError => exception
      error = true
      puts "error: #{exception.full_message()}"
      puts exception.backtrace.join('\n')
      puts "response = #{res}"
    ensure
      if (error)
        bill["category"].unshift(cat)
        pp res
        break
      end
    end

    # res = {
    #   status: 200,
    # }
    # error = res[:status] != 200

  end

  if (error)
    bills.unshift(bill)
    break
  end
end

File.write(continue_file, bills.to_json)
puts "Done."

# pp bill_items[0..4]

# bill_items.each do |bill|
#   puts bill["title"]
#   puts "======"

#   if bill["category"].kind_of?(Array)
#     bill["category"].each do |cat|
#       puts cat
#     end
#   elsif bill["category"].kind_of?(String)
#     puts bill["category"]
#   end

#   puts ""
# end

# Get status of bill page from the Research Publications page
# pp Uclassify::classify([all_text.join("\n")], "Frederick", "LHL_midterm_classifier")
