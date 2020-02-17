# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FetchHelper. For example:
#
# describe FetchHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FetchHelper, type: :helper do
  test_data = [{ 'code' => 'C-204', 'title' => 'An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760' }, { 'code' => 'C-3', 'title' => 'An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928' }, { 'code' => 'C-4', 'title' => 'An Act to implement the Agreement between Canada, the United States of America and the United Mexican States', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10615191' }, { 'code' => 'C-203', 'title' => 'An Act to amend the National Defence Act (maiming or injuring self or another)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10604049' }, { 'code' => 'S-207', 'title' => 'An Act to amend the Criminal Code (disclosure of information by jurors)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10607221' }, { 'code' => 'S-208', 'title' => 'An Act to amend the Criminal Code (independence of the judiciary)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10625187' }, { 'code' => 'S-210', 'title' => 'An Act to amend the Parliament of Canada Act (Parliamentary Visual Artist Laureate)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10625169' }, { 'code' => 'S-213', 'title' => 'An Act to change the name of the electoral district of Châteauguay—Lacolle', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10629396' }, { 'code' => 'S-1001', 'title' => 'An Act respecting Girl Guides of Canada', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10627060' }, { 'code' => 'S-212', 'title' => 'An Act to establish International Mother Language Day', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10627090' }, { 'code' => 'S-211', 'title' => 'An Act to enact the Modern Slavery Act and to amend the Customs Tariff', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10627038' }, { 'code' => 'C-202', 'title' => 'An Act to amend the Criminal Code (assault against a health care worker)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10618751' }, { 'code' => 'C-201', 'title' => 'An Act to develop a national school food program for children', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10618763' }, { 'code' => 'C-5', 'title' => 'An Act to amend the Judges Act and the Criminal Code', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10620333' }, { 'code' => 'S-209', 'title' => 'An Act to amend the Department for Women and Gender Equality Act', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10625194' }, { 'code' => 'S-202', 'title' => 'An Act to amend the Criminal Code (conversion therapy)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10604397' }, { 'code' => 'S-203', 'title' => 'An Act to amend the National Capital Act (buildings or works of national significance)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10604419' }, { 'code' => 'S-205', 'title' => 'An Act to amend the Constitution Act, 1867 and the Parliament of Canada Act (Speaker of the Senate)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10605949' }, { 'code' => 'S-206', 'title' => 'An Act to amend the Department of Public Works and Government Services Act (use of wood)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10605962' }, { 'code' => 'S-204', 'title' => 'An Act to amend the Criminal Code and the Immigration and Refugee Protection Act (trafficking in human organs)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10604425' }, { 'code' => 'S-201', 'title' => 'An Act to amend the Borrowing Authority Act', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10604365' }, { 'code' => 'C-1', 'title' => 'An Act respecting the administration of oaths of office', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10600395' }, { 'code' => 'S-1', 'title' => 'An Act relating to railways', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10601138' }]

  describe 'GetPageUrl' do
    it 'gets the page_url from a bill hash' do
      test_bill = { 'code' => 'C-204', 'title' => 'An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760' }
      test_url = 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760'

      expect(helper.get_page_url(test_bill)).to eq(test_url)
    end
  end

  describe 'GetFullTextUrl' do
    it 'fetches the full_text_url for a bill' do
      test_url = 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760'
      test_full_text_url = 'https://parl.ca/DocumentViewer/en/10633126'

      expect(helper.get_full_text_url(test_url)).to eq(test_full_text_url)
    end
  end

  describe 'GetIntroducedDate' do
    it 'fetches the introduced_date for a bill' do
      test_url = 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760'
      test_introduced_date = Date.parse('2020-02-07').to_s

      expect(helper.get_introduced_date(test_url)). to eq(test_introduced_date)
    end
  end

  describe 'GetDescription' do
    it 'fetches the description of a bill' do
      test_url = 'https://parl.ca/DocumentViewer/en/10633126'
      test_description = 'This enactment amends the Canadian Environmental Protection Act, 1999 to prohibit the export of certain types of plastic waste to foreign countries for final disposal.'

      expect(helper.get_description(test_url)).to eq(test_description)
    end
  end

  describe 'InsertColumnsIntoBills' do
    helper.insert_columns_into_bills(test_data)
    pp test_data

    it 'inserts columns into the bills hashes' do
      test_data.each do |test_bill|
        expect(test_bill).to have_key('full_text_url')
        expect(test_bill).to have_key('introduced_date')
        expect(test_bill).to have_key('description')
      end
    end
  end
end
