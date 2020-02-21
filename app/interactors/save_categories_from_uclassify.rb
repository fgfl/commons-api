class SaveCategoriesFromUclassify
  include Interactor::Organizer

  require "faraday"
  require "faraday_middleware"

  FormatUclassifyData,SaveBillCategories, 
end
