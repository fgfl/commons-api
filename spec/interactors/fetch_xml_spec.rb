require 'spec_helper'
require "rubygems"
require "nikkou"
require "open-uri"

RSpec.describe FetchXml, type: :interactor do
  subject(:context) { FetchXml.call(url: ENV["LEGISINFO_URL"]) }

  describe ".call" do
    context "when given valid url" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "returns valid xml" do
        valid_xml = Nokogiri::XML(context.data).errors.empty?
        expect(valid_xml).to eq(true)
      end
    end

    context "when given invalid url" do
      subject(:context) { FetchXml.call(url: "http://www.derp.com/thisdoesntexist") }
      it "fails" do
        expect(context).to be_a_failure
      end

      it "provides a failure message" do
        expect(context.message).to be_present
      end
    end
  end
end
