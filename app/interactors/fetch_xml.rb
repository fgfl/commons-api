# frozen_string_literal: true

class FetchXml
  include Interactor
  # Called by write_to_db organizer
  # Fetches the XML file from the LegisINFO site

  def call
    url = context.url

    xml_feed = Nokogiri::XML(URI.open(url)).to_xml
    url_exists = Faraday.head(url).status == 200
    valid_xml = Nokogiri::XML(xml_feed).errors.empty?

    if url_exists && valid_xml
      context.data = xml_feed
    else
      context.fail!(message: 'Fetch XML failed.')
    end
  end
end
