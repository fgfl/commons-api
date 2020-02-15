require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'Validations' do
    let(:category) { build(:random_category) }
    
    it "is valid with valid attributes" do
      pp category
      expect(category).to be_valid
    end

    it "is not valid without a name" do
      category.name = nil
      expect(category).to_not be_valid
    end

    it 'should save successfully' do
      expect(category.save).to eq(true)
    end
    
  end
end