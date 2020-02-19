class SplitArrays
  include Interactor
  # Called by write_to_db organizer
  # Splits the array of hashes into two separate arrays, one for Events and one for Bills

  # Note: From here on in the organizer sequence there are two contexts: Events and Bills

  def call
    items = context.data
    split_arrays = [[], []]
    hash_keys = %w[bill_code title pubDate]
    items.each do |event|
      event, bill = event.partition { |k, _v| hash_keys.include? k }.map(&:to_h)
      split_arrays[0].push(event)
      split_arrays[1].push(bill)
    end

    context.events = split_arrays[0]
    context.bills = split_arrays[1]
  end
end
