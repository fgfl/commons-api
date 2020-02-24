# frozen_string_literal: true

class EventsController < ApplicationController
  def show
    @events = Bill.find_by_id(bill_params.to_i).events.all

    if @events
      render json: {
        events: @events
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end

  private

  def bill_params
    params.require(:id)
  end
end
