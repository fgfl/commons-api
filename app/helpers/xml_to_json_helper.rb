require "json"
require "active_support/all"

module XmlToJsonHelper
  # Converts xml string to json
  # input: String - must be contained in one tag. The below is ok. It will not work without the containing div
  #   "<div>
  #       <hello></hello>
  #       <category></category>
  #   </div>"
  # Returns a JSON string. Call JSON.parse() to get a hash from the string
  def xml_to_json(xml)
    Hash.from_xml(xml).to_json
  end
end
