require "rubygems"
require "nikkou"
require "open-uri"
require "faraday"

class WriteToDb
  include Interactor::Organizer
  # Called as a scheduled ActiveJob
  # This organizer runs through the process of fetching, formatting and organizing all the data related to Bills and Events

  organize FetchXml, FormatToHashes, FormatDate, FormatCode, SplitArrays, RemoveDuplicates, InsertColumns, SaveBills, SaveEvents, UpdateBillsPassed
end
