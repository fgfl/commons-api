# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bill, type: :model do
  describe "Validations" do
    let(:bill) { build(:random_bill) }
    let(:bill2) { build(:random_bill) }

    it "is valid with valid attributes" do
      expect(bill).to be_valid
    end

    it "is valid if the introduced_date is a Date object" do
      bill.introduced_date = Faker::Date.backward(days: 365)
      expect(bill).to be_valid
    end

    it "is not valid if introduced date is in the future" do
      bill.introduced_date = Faker::Date.forward(days: 365)
      expect(bill).to_not be_valid
    end

    # it "is not valid if introduced_date is not a Date object or nil" do
    #   bill.introduced_date = Faker::Games::ElderScrolls.region
    #   pp bill
    #   expect(bill).to_not be_valid
    # end

    it "is not valid without a code" do
      bill.code = nil
      expect(bill).to_not be_valid
    end

    it "is not valid without a page_url" do
      bill.page_url = nil
      expect(bill).to_not be_valid
    end

    it "is not valid if code is not unique" do
      bill2.code = bill.code
      bill2.save
      expect(bill).to_not be_valid
    end

    it "should save successfully" do
      expect(bill.save).to eq(true)
    end
  end
end
