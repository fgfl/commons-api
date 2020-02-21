class FetchUclassifyData
  include Interactor

  require "faraday"
  require "faraday_middleware"

  def call(text, username, classifierName)
    base_url = "https://api.uclassify.com/v1/"

    uri = "#{base_url}#{username}/#{classifierName}/classify"

    body = {
      texts: text,
    }

    faraday = Faraday.new(url: uri) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter :net_http
    end
    res = faraday.post do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Token #{Rails.application.secrets.api_read_key}"
      req.body = body
    end
  end
end
