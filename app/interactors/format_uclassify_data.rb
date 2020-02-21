class FormatUclassifyData
  include Interactor

  test_data = File.read('../../spec/support/test_uclassify_data.json')
  test_hash = JSON.parse(test_data)

  def call
    puts test_hash
  end
end
