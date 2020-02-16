# frozen_string_literal: false

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FormatDateHelper. For example:
#
# describe FormatDateHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FormatDateHelper, type: :helper do
  test_data = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
  test_data_formatted = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020' }]
  method_output = helper.format_date(test_data)

  it 'removes the time portion of the date string' do
    expect(method_output).to eq(test_data_formatted)
  end

  it 'stores the date object in the hash as a string' do
    method_output.each do |item|
      expect(item['pubDate']).to be_a String
    end
  end
end
