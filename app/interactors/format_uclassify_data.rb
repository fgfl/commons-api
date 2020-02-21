class FormatUclassifyData
  include Interactor
  # Formats the data received by uClassify for a single bill

  # The call function sorts the JSON returned by uClassify by probability
  # It then selects categories until a given threshold is exceed by the sum of the probailities
  # DEV NOTE: 'threshold' may need to be tweaked

  def call
    test_data = File.read(__dir__ + "/../../spec/support/test_uclassify_data.json")
    unsorted_array = JSON.parse(test_data)[0]["classification"]
    classification_array = unsorted_array.sort_by! { |k| k["p"] }.reverse
    threshold = 0
    categories = []
    classification_array.each do |category|
      categories.push(category["className"])
      threshold += category["p"]
      if threshold >= 0.8
        break
      end
    end
    context.categories = categories
  end
end
