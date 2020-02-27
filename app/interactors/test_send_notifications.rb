class TestSendNotifications
  include Interactor::Organizer

  organize TestGetEventsForDay, GetSubscribersFromEvents, SendNotifications
end
