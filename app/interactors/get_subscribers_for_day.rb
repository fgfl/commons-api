class GetSubscribersForDay
  include Interactor::Organizer

  organize GetEventsForTheDay, GetSubscribersFromEvents
end
