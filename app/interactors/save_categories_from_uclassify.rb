class SaveCategoriesFromUclassify
  include Interactor::Organizer
  # PART ONE OF SAVING CATEGORIES
  # Called by the Scheduled Task Runner
  # Gets the text from every bill daved to the database that day
  # then calls the ClassifyAndSaveCategories organizer on each text

  organize GetBillsForTheDay, GetTextFromFromBill
end