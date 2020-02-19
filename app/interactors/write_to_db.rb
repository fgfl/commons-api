class WriteToDb
  include Interactor::Organizer

  organize FetchXml, FormatToHashes, FormatDate, FormatCode, SplitArrays, RemoveDuplicates
end
