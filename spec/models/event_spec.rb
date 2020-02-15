require 'rails_helper'

RSpec.describe Event, type: :model do

  describe 'Validations' do
    let(:event) { build(:random_event) }
    
    it "is valid with valid attributes" do
      pp event
      expect(event).to be_valid
    end

    it "is not valid without a title" do
      event.title = nil
      expect(event).to_not be_valid
    end

    it "is not valid without a publication_date" do
      event.publication_date = nil
      expect(event).to_not be_valid
    end

    it "is not valid if publication date is in the future" do
      event.publication_date = Faker::Date.forward(days: 365)
      expect(event).to_not be_valid
    end

    it 'should save successfully' do
      expect(event.save).to eq(true)
    end
    
  end
end

