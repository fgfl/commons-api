# frozen_string_literal: true

require_relative "../helpers/write_database_helper"
include WriteDatabaseHelper

class BillsController < ApplicationController
  def new; end

  def create
    write_bills
    head :ok, content_type: "text/html"
  end

  private
end
