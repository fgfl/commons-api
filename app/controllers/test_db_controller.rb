class TestDbController < ApplicationController

  def create
    url = ENV["legisinfo_url"]
    WriteToDb.call({url: url})
    head :ok, content_type: "text/html"
  end

end
