require "dotenv"
Dotenv.load
require "faraday"
require "faraday_middleware"

module Uclassify
  # Sends read call to uClassify
  # inputs: text {[string]} - array of text to classify
  def self.classify(text, username, classifierName, token)
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
      req.headers["Authorization"] = "Token #{token}"
      req.body = body
      # req.body = "{\"texts\": [\"hello\"]}"
    end
  end

  # Sends training text to the classifier
  # {[""]}: text - to train
  # {""}: classifierName
  # {""}: className
  def self.train(text, classifierName, className)
    base_url = "https://api.uclassify.com/v1/me/"
    url = "#{base_url}#{classifierName}/#{className}/train"

    body = {
      texts: text,
    }

    faraday = Faraday.new(url: url) do |conn|
      # conn.token_auth("#{ENV["UCLASSIFY_API_READ_KEY"]}") # this doesn't work???? must put in header.
      conn.request :json #, :content_type => /\bjson$/
      conn.response :json, :content_type => /\bjson$/
      conn.adapter :net_http
    end

    res = faraday.post do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Token #{ENV["UCLASSIFY_API_WRITE_KEY"]}"
      req.body = body
    end
  end
end
