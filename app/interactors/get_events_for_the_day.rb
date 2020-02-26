# frozen_string_literal: true

class GetEventsForTheDay
  include Interactor

  def call
    events_for_day = Event.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

    context.events = events_for_day
  end
end
