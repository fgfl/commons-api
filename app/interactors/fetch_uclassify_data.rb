class FetchUclassifyData
  include Interactor

  require "dotenv"
  require "faraday"

  # Called as part of the SaveCategoriesFromUclassify organizer chain
  # Makes call to uClassify API to get category probabilities back

  def call
    full_text = context.full_text

    text = [full_text.join(" ")]
    username = ENV["UCLASSIFY_USERNAME"]
    classifier_name = ENV["CLASSIFIER_NAME"]
    token = ENV["API_READ_KEY"]
    base_url = "https://api.uclassify.com/v1/"

    uri = "#{base_url}#{username}/#{classifier_name}/classify"

    body = {
      texts: text,
    }

    faraday = Faraday.new(url: uri) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter :net_http
    end

    response = faraday.post do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Token #{token}"
      req.body = body
    end

    context.response = response.body
  end
end
