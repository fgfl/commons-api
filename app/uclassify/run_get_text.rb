require_relative "../helpers/get_bill_text_from_summary_helper"
require "pry"

bill = JSON.parse('[{"xml:base":"https://hillnotes.ca/2020/02/13/5g-technology-opportunities-challenges-and-risks/","author":{"name":"Sarah Lemelin-Bellerose"},"category":["Information and communications","Science and technology"],"title":"5G Technology: Opportunities, Challenges and Risks","description":"https://hillnotes.ca/2020/02/13/5g-technology-opportunities-challenges-and-risks/","pubDate":"Thu, 13 Feb 2020 00:00:00 -0500"},{"xml:base":"https://lop.parl.ca/sites/PublicWebsite/default/en_CA/ResearchPublications/201943E","author":{"name":"Marlisa Tiedemann"},"category":["Law, justice and rights","Social affairs and population","Health and safety"],"title":"Assisted Dying in Canada After Carter v. Canada","description":"https://lop.parl.ca/sites/PublicWebsite/default/en_CA/ResearchPublications/201943E","pubDate":"Fri, 29 Nov 2019 00:00:00 -0500"}]')

p text = GetBillTextFromSummaryHelper::get_publication_text(bill[1])

binding.pry

