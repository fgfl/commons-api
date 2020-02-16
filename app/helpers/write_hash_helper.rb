# frozen_string_literal: true

require 'json'
require 'active_support/all'

require_relative './format_bill_helper'
include FormatBillHelper

module WriteHashHelper
  def split_events(items); end

  def write_hash(read_path, write_path)
    file_data = File.read(__dir__ + read_path)
    hash = JSON.parse(Hash.from_xml(file_data).to_json)
    items = hash['rss']['channel']['item']
    format_date(items)
    File.write(__dir__ + write_path, items)
  end
end
