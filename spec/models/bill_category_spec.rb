require "rails_helper"

RSpec.describe BillCategory, type: :model do
  describe "Validations" do
    let(:bill_category) { build(:bill_category) }

    it "is valid with valid attributes" do
      pp bill_category
      expect(bill_category).to be_valid
    end

    it "should save successfully" do
      expect(bill_category.save).to eq(true)
    end
  end
end
