# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WriteDatabaseHelper. For example:
#
# describe WriteDatabaseHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe WriteDatabaseHelper, type: :helper do
  test_data = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-204, Debate and Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
  test_event_data = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-204, Debate and Second Reading in the House of Commons', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
  test_bill_data = [{ 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)' }, { 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts' }]

  describe 'SplitHash' do
    it 'splits the full hash into separate arrays' do
      split_hash = helper.split_hash(test_data)
      events = split_hash[0]
      bills = split_hash[1]
      expect(split_hash).to be_kind_of(Array)
      expect(events).to be_kind_of(Array)
      expect(bills).to be_kind_of(Array)
    end

    it 'splits the full hash into the proper data' do
      split_hash = helper.split_hash(test_data)
      events = split_hash[0]
      bills = split_hash[1]
      expect(events).to eq(test_event_data)
      expect(bills).to eq(test_bill_data)
    end

    it 'does not create duplicates in the bills array' do
      split_hash = helper.split_hash(test_data)
      events = split_hash[0]
      bills = [split_hash[1]]
      expect(bills).to contain_exactly(test_bill_data)
    end
  end
end
