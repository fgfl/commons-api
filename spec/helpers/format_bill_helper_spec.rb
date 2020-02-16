# frozen_string_literal: false

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FormatBillHelper. For example:
#
# describe FormatBillHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FormatBillHelper, type: :helper do
  test_data = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
  test_data_formatted = [{ 'code' => 'C-204', 'event_title' => 'Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'bill_title' => 'An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020' }, { 'code' => 'C-3', 'event_title' => 'Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'bill_title' => 'An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020' }]
  date_formatted = helper.format_date(test_data)
  code_formatted = helper.format_code(date_formatted)
  title_formatted = helper.rename_titles(code_formatted)
  method_output = title_formatted

  it 'formats the bill correctly' do
    expect(method_output).to eq(test_data_formatted)
  end

  describe 'FormatDateHelper' do
    test_data_date = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
    test_data_date_formatted = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020' }]
    format_date_output = helper.format_date(test_data_date)

    it 'removes the time portion of the date string' do
      expect(format_date_output).to eq(test_data_date_formatted)
    end

    it 'stores the date object in the hash as a string' do
      format_date_output.each do |item|
        expect(item['pubDate']).to be_a String
      end
    end
  end

  describe 'FormatCodeHelper' do
    test_data_code = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
    test_data_code_formatted = [{ 'code' => 'C-204', 'title' => 'Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'code' => 'C-3', 'title' => 'Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
    format_code_output = helper.format_code(test_data_code)

    it 'formats the bill code, title and description' do
      expect(format_code_output).to eq(test_data_code_formatted)
    end
  end

  describe 'RenameTitlesHelper' do
    test_data_titles = [{ 'title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'description' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'description' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
    test_data_titles_formatted = [{ 'event_title' => 'C-204, Introduction and First Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'bill_title' => 'C-204, An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }, { 'event_title' => 'C-3, Debate at Second Reading in the House of Commons', 'link' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'bill_title' => 'C-3, An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'pubDate' => 'Fri, 07 Feb 2020 00:00:00 EST' }]
    rename_titles_output = helper.rename_titles(test_data_titles)

    it 'renames the titles appropriately for events and bills' do
      expect(rename_titles_output).to eq(test_data_titles_formatted)
    end
  end
end
