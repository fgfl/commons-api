class FetchUclassifyData
  include Interactor

  require_relative "../uclassify/uclassify.rb"

  require "faraday"
  require "faraday_middleware"

  def call
    bills_for_day = context.bills_for_day
    raise bills_for_day.inspect

    Uclassify.classify()
  end
end
