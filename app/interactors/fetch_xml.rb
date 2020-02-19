class FetchXml
  include Interactor
  # Called by write_to_db organizer
  # Fetches the XML file from the LegisINFO site

  def call
    url = ENV["legisinfo_url"]
    xml_feed = Nokogiri::XML(URI.open(url)).to_xml
    if xml_feed.present?
      context.data = xml_feed
    else
      context.fail!(message: "Fetch XML failed.")
    end
  end
end
