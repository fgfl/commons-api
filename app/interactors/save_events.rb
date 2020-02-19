class SaveEvents
  include Interactor
  # Called by write_to_db organizer
  # This interactor saves the Events to the database
  # Events are associated to certain Bills by the 'code' field present in both tables

  def call
    events = context.events
    events.each do |event|
      puts event
      puts "Writing Event #{event["code"]} #{event["title"]} to database ..."
      bill = Bill.find_by code: event["code"]
      Event.create(
        bill: bill,
        code: event["code"],
        title: event["title"],
        publication_date: Date.parse(event["publication_date"]),
      )
    end
    puts "Finished writing #{events.length} events to the database!"
  end
end
