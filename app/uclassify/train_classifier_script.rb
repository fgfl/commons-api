require "pry"

# include Uclassify
require_relative "./uclassify"

require_relative "../helpers/xml_to_json_helper"
require_relative "../helpers/get_bill_text_from_summary_helper"
require_relative "../helpers/category_mapper_helper"
include XmlToJsonHelper

CLASSIFIER_NAME = "Commons_api"

Struct.new("Response", :status)

def train(type)
  error_file = __dir__ + "/errors/#{DateTime.now}.json"
  errors = []
  continue_file = __dir__ + "/training_data/continue_training_data.json"

  if (File.exists?(continue_file))
    input_file = continue_file
  else
    input_file = __dir__ + "/training_data/research_publications.json"
  end

  bills = JSON.parse(File.read(input_file))

  result = catch(:uClassify_error) {
    # while bills.size > 0

    # just run 4 bills to test
    (0..3).each do |n|
      bill = bills.shift

      pp bill["title"]

      begin
        if bill["category"].nil?
          raise StandardError.new "Nil category"
        end

        if bill["category"].kind_of?(String)
          bill["category"] = [bill["category"]]
        end

        # binding.pry

        case type
        when "legis_summary"
          text = GetBillTextFromSummaryHelper::get_bill_text(bill)
        when "publications"
          text = GetBillTextFromSummaryHelper::get_publication_text(bill)
        else
          text = []
        end

        # binding.pry
        if text.empty?
          raise StandardError.new "Empty text found"
        end
      rescue StandardError => e
        errors.push({ exception: e, bill: bill })
        next
      end

      while bill["category"].size > 0
        cat = bill["category"].shift
        pp "-- #{cat}"

        begin
          # res = Uclassify::train(text, CLASSIFIER_NAME, CategoryMapperHelper::map(cat))
          res = Struct::Response.new(200)
          unless res.status == 200
            raise StandardError.new "Failed uClassify train."
          end
        rescue Net::ReadTimeout, Faraday::TimeoutError, StandardError => exception
          puts "error: #{exception.full_message()}"
          puts "response = #{res}"

          bill["category"].unshift(cat)
          bills.unshift(bill)
          File.write(continue_file, bills.to_json)

          result = { exception: exception, response: res, bill: bill }
          errors.push(result)

          throw :uClassify_error, result
        end
      end
    end
  }

  unless errors.empty?
    File.open(error_file, "w") { |f|
      f.write(errors.to_json)
    }
  end

  puts "Done. #{result}"
end

## START SCRIPT
unless ARGV[0] == "legis_summary" || ARGV[0] == "publications"
  puts "We need exactly one arguments"
  puts "Run:"
  puts "ruby ./train_classifier_script.rb (legis_summary|publications)"
  exit
else
  train ARGV[0]
end
