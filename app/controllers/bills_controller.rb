# frozen_string_literal: true

class BillsController < ApplicationController
  def new; end

  def create
    WriteToDb.call
    head :ok, content_type: "text/html"
  end

  private
end
