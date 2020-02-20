# # frozen_string_literal: true

# require 'rails_helper'

# # Specs in this file have access to a helper object that includes
# # the XmlToJsonHelper. For example:
# #
# # describe XmlToJsonHelper do
# #   describe "string concat" do
# #     it "concats two strings with spaces" do
# #       expect(helper.concat_strings("this","that")).to eq("this that")
# #     end
#   end
# # end
# RSpec.describe XmlToJsonHelper, type: :helper do
#   it 'returns a JSON object when passed valid XML' do
#     xml = "
#         <channel>
#             <description>The Parliamentary Information and Research Service prepares publications for general distribution to all Parliamentarians as background material to policy areas and legislation before Parliament.</description>
#             <language>en_CA</language>
#             <managingEditor>Library of Parliament</managingEditor>
#             <category>Research Publications</category>
#         </channel>
#     "
#     json = '{"channel":{"description":"The Parliamentary Information and Research Service prepares publications for general distribution to all Parliamentarians as background material to policy areas and legislation before Parliament.","language":"en_CA","managingEditor":"Library of Parliament","category":"Research Publications"}}'
#     method_output = helper.xml_to_json(xml)

#     expect(method_output).to eq(json)
#   end
# end
