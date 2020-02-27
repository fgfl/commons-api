# frozen_string_literal: true

class TestGetEventsForTheDay
  include Interactor

  def call
    events_for_day = Event.all.where(code: "C-235")

    context.events = events_for_day
  end
end
