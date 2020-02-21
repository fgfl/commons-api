class FetchUclassifyData
  include Interactor

  def call(text, username, classifierName)
    base_url = "https://api.uclassify.com/v1/"
    # username = "Frederick"
    # classifierName = "LHL_midterm_classifier"

    uri = "#{base_url}#{username}/#{classifierName}/classify"

    body = {
      texts: text,
    }

    faraday = Faraday.new(url: uri) do |conn|
      # conn.token_auth("#{ENV["UCLASSIFY_API_READ_KEY"]}") # this doesn't work???? must put in header.
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter :net_http
    end
    res = faraday.post do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Token #{Rails.application.secrets.api_read_key}"
      req.body = body
      # req.body = "{\"texts\": [\"hello\"]}"
    end
  end
end
