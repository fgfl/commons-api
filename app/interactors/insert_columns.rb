# frozen_string_literal: true

class InsertColumns
  include Interactor::Organizer
  # Called by write_to_db organizer

  # This organizer handles all of the fetches to fill in missing fields in the Bills hashes

  organize FetchFullTextUrl, FetchIntroducedDate, FetchDescription
end
