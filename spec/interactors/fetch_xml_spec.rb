# frozen_string_literal: true

require 'spec_helper'
require 'rubygems'
require 'nikkou'
require 'open-uri'

RSpec.describe FetchXml, type: :interactor do
  subject(:context) { FetchXml.call(url: 'https://www.parl.ca/LegisInfo/RSSFeed.aspx?download=rss&Language=E&Mode=1&Source=LegislativeFilteredBills&AllBills=1&HOCEventTypes=60110,60111,60146,60306,60122,60115,60119,60121,60124,60125,60126,60127,60285,60145,60307,60128,60131,60132,60133,60134,60174,60112,60163,60304,60303,60139,60144,60136,60138,60142&SenateEventTypes=60109,60110,60111,60115,60118,60119,60120,60123,60124,60305,60286,60130,60129,60302,60131,60132,60133,60134,60147,60304,60303,60140,60143,60135,60137,60141,60149') }

  describe '.call' do
    context 'when given valid url' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      # it "returns valid xml" do
      #   valid_xml = Nokogiri::XML(context.url).errors.empty?
      #   expect(valid_xml).to eq(true)
      # end
    end

    context 'when given invalid url' do
      subject(:context) { FetchXml.call(url: 'http://www.derp.com/thisdoesntexist') }
      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
