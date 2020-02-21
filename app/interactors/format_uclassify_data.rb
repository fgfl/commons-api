class FormatUclassifyData
  include Interactor
  # Formats the data deceived by uClassify

  def call
    test_data = File.read(__dir__ + '/../../spec/support/test_uclassify_data.json')
    unsorted_array = JSON.parse(test_data)[0]["classification"]
    classification_array = unsorted_array.sort_by!{ |k| k["p"]}.reverse
    threshold = 0
    categories = []
    classification_array.each do |category|
      categories.push(category["className"])
      threshold += category["p"]
      if threshold >= 0.8
        break
      end
    end
    raise categories.inspect
  end
end
