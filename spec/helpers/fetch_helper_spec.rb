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
  test_data = [{ 'code' => 'C-204', 'title' => 'An Act to amend the Canadian Environmental Protection Act, 1999 (final disposal of plastic waste)', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760' }, { 'code' => 'C-3', 'title' => 'An Act to amend the Royal Canadian Mounted Police Act and the Canada Border Services Agency Act and to make consequential amendments to other Acts', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928' }, { 'code' => 'C-4', 'title' => 'An Act to implement the Agreement between Canada, the United States of America and the United Mexican States', 'page_url' => 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10615191' }]

  describe 'GetPageUrls' do
    it 'returns the page_url values of the bills array' do
      test_page_urls = ['https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760', 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10613928', 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10615191']

      expect(helper.get_page_urls(test_data)).to eq(test_page_urls)
    end
  end

  describe 'GetFullTextUrls' do
    it 'fetches the html for each of the page urls' do
      test_full_page_urls = ['https://parl.ca/DocumentViewer/en/10633126', 'https://parl.ca/DocumentViewer/en/10615687', 'https://parl.ca/DocumentViewer/en/10617993']

      expect(helper.get_full_text_urls(test_data)).to eq(test_full_page_urls)
    end
  end
end
