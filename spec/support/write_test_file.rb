# frozen_string_literal: true

# "../../spec/support/legisinfo_test_data.xml"
# "../../spec/support/legisinfo_test_data"

require_relative '../../app/helpers/write_json_helper'
include WriteJsonHelper

read_path = '/../../spec/support/legisinfo_test_data.xml'
write_path = '/../../spec/support/legisinfo_test_data.json'

write_json(read_path, write_path)
