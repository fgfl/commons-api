require_relative "../helpers/xml_to_json_helper"
include XmlToJsonHelper
require_relative "./uclassify"
# include Uclassify
require_relative "../helpers/get_bill_text_from_summary_helper"
require_relative "../helpers/category_mapper_helper"

require "pry"

#=========

# set up bills in rb file for saving which needs to be sent to uclassify

# file_data = File.read(__dir__ + "/training_data/publications_with_category.xml")

# # File.write(__dir__ + "/test.json", (xml_to_json(file_data)))
# items = JSON.parse(xml_to_json(file_data))["rss"]["channel"]["item"]
# bill_items = items.select do |item|
#   item["title"].include? "Legislative Summary"
# end

# File.write(__dir__ + "/legislative_summary_bills.json", bill_items.to_json)

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

  if bill["category"].nil?
    next
  end

  pp bill["title"]
  text = GetBillTextFromSummaryHelper::get_text(bill)

  if text.empty?
    next
  end
  # text = "tests text"

  if bill["category"].kind_of?(String)
    bill["category"] = [bill["category"]]
  end

  # binding.pry

  error = false

  while bill["category"].size > 0
    cat = bill["category"].shift
    # res = Uclassify::train(text, CLASSIFIER_NAME, CategoryMapperHelper::map(cat))
    # error = res.status != 200

    res = {
      status: 200,
    }
    error = res[:status] != 200

    if (error)
      bill["category"].unshift(cat)
      pp res
      break
    end
  end

  if (error)
    bills.unshift(bill)
    break
  end
end

File.write(continue_file, bills.to_json)
binding.pry

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
