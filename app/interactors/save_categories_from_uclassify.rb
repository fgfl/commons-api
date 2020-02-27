# frozen_string_literal: true

class SaveCategoriesFromUclassify
  include Interactor::Organizer
  require 'dotenv'
  require 'faraday'

  # PART ONE OF SAVING CATEGORIES
  # Called by the Scheduled Task Runner
  # Gets the text from every bill daved to the database that day
  # then calls the ClassifyAndSaveCategories organizer on each text

  organize GetBillsForDay, GetTextFromFromBill
end
