# frozen_string_literal: true

require "json"
require "active_support/all"

module WriteJsonHelper
  def write_json(read_path, write_path)
    file_data = File.read(__dir__ + read_path)
    items = Hash.from_xml(file_data).as_json["rss"]["channel"]["item"].to_json
    File.write(__dir__ + write_path, items)
  end
end
