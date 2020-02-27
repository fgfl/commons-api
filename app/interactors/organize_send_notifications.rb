# frozen_string_literal: true

class OrganizeSendNotifications
  include Interactor::Organizer

  organize GetEventsForDay, GetSubscribersFromEvents, SendNotifications
end
