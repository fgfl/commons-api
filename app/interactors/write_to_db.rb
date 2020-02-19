require "rubygems"
require "nikkou"
require "open-uri"

class WriteToDb
  include Interactor::Organizer

  organize FetchXml, FormatToHashes, FormatDate, FormatCode, SplitArrays, RemoveDuplicates, InsertColumns, SaveBills, SaveEvents
end
