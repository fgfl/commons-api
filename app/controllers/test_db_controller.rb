class TestDbController < ApplicationController

  def create
    url = Rails.application.secrets.LEGISINFO_URL
    WriteToDb.call({url: url})
    head :ok, content_type: "text/html"
  end

end
