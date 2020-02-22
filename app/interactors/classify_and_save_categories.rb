class ClassifyAndSaveCategories
  include Interactor::Organizer

  organize FetchUclassifyData, FormatUclassifyData, SaveBillCategories
end
