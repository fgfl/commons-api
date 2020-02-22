class FormatUclassifyData
  include Interactor

  require 'pry'
  # Formats the data received by uClassify for a single bill

  # The call function sorts the JSON returned by uClassify by probability
  # It then selects categories until a given threshold is exceed by the sum of the probailities
  # DEV NOTE: 'threshold' may need to be tweaked

  def call
    threshold = 0.8
    total_probability = 0
    categories = []
    
    # test_data = File.read(__dir__ + "/../../spec/support/test_uclassify_data.json")
    response = context.response
    unsorted_array = response[0]["classification"]
    classification_array = unsorted_array.sort_by! { |k| k["p"] }.reverse
    classification_array.each do |category|
      categories.push(category["className"])
      total_probability += category["p"]
      if total_probability >= threshold
        break
      end
    end
    context.categories = categories
    binding.pry
  end
end
