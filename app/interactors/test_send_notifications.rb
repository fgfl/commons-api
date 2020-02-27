class GetSubscribersForDay
  include Interactor::Organizer

  organize TestGetEventsForTheDay, GetSubscribersFromEvents, SendNotifications
end
