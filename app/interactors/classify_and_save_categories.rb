class ClassifyAndSaveCategories
  include Interactor::Organizer
  # PART TWO OF SAVING CATEGORIES
  # Called by each iteration of the loop in GetTextFromFromBill
  # Gets uClassify data for each bill and saves it to the billcategories join table

  organize FetchUclassifyData, FormatUclassifyData, SaveBillCategories
end
