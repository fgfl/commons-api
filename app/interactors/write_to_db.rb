# frozen_string_literal: true

require 'rubygems'
require 'nikkou'
require 'open-uri'

class WriteToDb
  include Interactor::Organizer
  # Called as a scheduled task using Whenever gem
  # This organizer runs through the process of fetching, formatting and organizing all the data related to Bills and Events

  organize FetchXml, FormatToHashes, FormatDate, FormatCode, SplitArrays, RemoveDuplicates, InsertColumns, SaveBills, SaveEvents, UpdateBillsPassed
end
