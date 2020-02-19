class FormatDate
  include Interactor

  def call
    items = context.data
    items.each do |item|
      item["pubDate"].slice! " 00:00:00 EST"
    end
    context.data = items
  end
end
