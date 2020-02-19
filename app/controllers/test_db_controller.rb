class TestDbController < ApplicationController

  def create
    WriteToDb.call
    head :ok, content_type: "text/html"
  end

end
