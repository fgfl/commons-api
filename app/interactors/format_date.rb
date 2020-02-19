class FormatDate
  include Interactor
  # Called by write_to_db organizer
  # Removes the time string from the end of the date field

  def call
    items = context.data
    items.each do |item|
      item["pubDate"].slice! " 00:00:00 EST"
    end

    context.data = items
  end
end
