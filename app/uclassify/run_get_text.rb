require_relative "../helpers/get_bill_text_from_summary_helper"
require "pry"

bill = {
  "xml:base" => "https://lop.parl.ca/sites/PublicWebsite/default/en_CA/ResearchPublications/LegislativeSummaries/403C51E",
  "author" => [
    { "name" => "Dominique Valiquet" },
    { "name" => "Katherine Simonds" },
  ],
  "category" => ["Law, justice and rights", "Science and technology"],
  "title" => "Legislative Summary of Bill C-51: Investigative Powers for the 21st Century Act",
  "description" => "https://lop.parl.ca/sites/PublicWebsite/default/en_CA/ResearchPublications/LegislativeSummaries/403C51E",
  "pubDate" => "Thu, 03 Feb 2011 00:00:00 -0500",
}

text = GetBillTextFromSummaryHelper::get_text(bill)

binding.pry
