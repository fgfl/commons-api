class FetchUclassifyData
  include Interactor

  require_relative "../uclassify/uclassify.rb"

  # Called as part of the SaveCategoriesFromUclassify organizer chain
  # Makes call to uClassify API to get category probabilities back

  def call
    full_text = context.full_text

    full_text = [full_text.join(" ")]
    username = ENV["UCLASSIFY_USERNAME"]
    classifier_name = ENV["CLASSIFIER_NAME"]
    token = ENV["API_READ_KEY"]

    # Calls uClassify method from uClassify folder to get probabilities back
    # DEV NOTE: If uClassify calls are used up, switch 'api_read_key' in secrets.yml file
    response = Uclassify.classify(full_text, username, classifier_name, token)
    context.response = response.body
  end
end
