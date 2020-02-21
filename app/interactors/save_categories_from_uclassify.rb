class SaveCategoriesFromUclassify
  include Interactor::Organizer

  organize GetBillsForTheDay, FetchUclassifyData, FormatUclassifyData, SaveBillCategories
end
