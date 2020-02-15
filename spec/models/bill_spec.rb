require 'rails_helper'

RSpec.describe Bill, type: :model do

  describe 'Validations' do
    let(:bill) { build(:random_bill) }
    
    it "is valid with valid attributes" do
      pp bill
      expect(bill).to be_valid
    end

    it "is not valid without a code" do
      bill.code = nil
      expect(bill).to_not be_valid
    end

    it "is not valid without a description" do
      bill.description = nil
      expect(bill).to_not be_valid
    end

    it "is not valid without a tabled_date" do
      bill.tabled_date = nil
      expect(bill).to_not be_valid
    end

    it "is not valid without a page_url" do
      bill.page_url = nil
      expect(bill).to_not be_valid
    end

    it "is not valid without a full_text_url" do
      bill.full_text_url = nil
      expect(bill).to_not be_valid
    end

    it "is not valid if publication date is in the future" do
      bill.tabled_date = Faker::Date.forward(days: 365)
      expect(bill).to_not be_valid
    end

    it 'should save successfully' do
      expect(bill.save).to eq(true)
    end
    
  end
end

