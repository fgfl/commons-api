class FormatCode
  include Interactor

  def call
    items = context.data
    items.each do |item|
      bill_code = item["title"].split(", ").first
      item["title"].sub! /\A.+?(?=, )/mi, ""
      item["description"].sub! /\A.+?(?=, )/mi, ""
      item["title"].slice!(0, 2)
      item["description"].slice!(0, 2)
      item["code"] = bill_code
      item["bill_code"] = bill_code
    end
    context.data = items
  end
end
