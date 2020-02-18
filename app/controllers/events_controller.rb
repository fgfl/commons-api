# frozen_string_literal: true

require_relative "../helpers/write_database_helper"
include WriteDatabaseHelper

class EventsController < ApplicationController
  def new; end

  def create
    write_events
  end

  private
end
