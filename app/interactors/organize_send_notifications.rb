# frozen_string_literal: true

class OrganizeSendNotifications
  include Interactor::Organizer

  organize GetEventsForTheDay, GetSubscribersFromEvents, SendNotifications
end
