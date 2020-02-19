require 'spec_helper'

RSpec.describe FormatToHashes, type: :interactor do
  subject(:context) { WriteToDb.call }

  describe "format_to_hashes" do
    subject(:context) { FormatToHashes.call() }
    context "when given valid xml" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "converts xml to array of hashes" do
        expect(context.data).to be_a(array)
      end
    end

  end
end
