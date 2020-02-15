require_relative "../helpers/xml_to_json_helper"
include XmlToJsonHelper

file_data = File.read(__dir__ + "/training_data/publications_with_category.xml")

File.write(__dir__ + "test.json", xml_to_json(file_data))
