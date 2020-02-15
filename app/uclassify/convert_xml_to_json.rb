require "json"
require "active_support/all"

xml = "
    <div>
    <description>The Parliamentary Information and Research Service prepares publications for general distribution to all Parliamentarians as background material to policy areas and legislation before Parliament.</description>
    <language>en_CA</language>
    <managingEditor>Library of Parliament</managingEditor>
    <category>Research Publications</category>
    </div>
"
# File.open("test.json", "a")

# File.foreach("training_data/publications_with_category.xml") { |line| File.write("test.json", Hash.from_xml(line).to_json, mode: "a") }

file_data = File.read("training_data/publications_with_category.xml")

File.write("test.json", Hash.from_xml(file_data).to_json)
