# frozen_string_literal: true

class EventsController < ApplicationController
  def new; end

  def create
    write_events
  end

  private
end
