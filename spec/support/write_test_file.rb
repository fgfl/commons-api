# frozen_string_literal: true

# "../../spec/support/legisinfo_test_data.xml"
# "../../spec/support/legisinfo_test_data"

require_relative "../../app/helpers/write_database_helper"
include WriteDatabaseHelper

read_path = "/../../spec/support/legisinfo_test_data.xml"
write_path = "/../../spec/support"

write_hashes_array(read_path, write_path)
