require 'rails_helper'

RSpec.describe Session, type: :model do

  describe 'Validations' do
    let(:session) { build(:random_session) }
    
    it "is valid with valid attributes" do
      pp session
      expect(session).to be_valid
    end

    it "is not valid without a start_date" do
      session.start_date = nil
      expect(session).to_not be_valid
    end

    it "is not valid if start_date is not in the past" do
      session.start_date = Faker::Date.forward(days: 365)
      expect(session).to_not be_valid
    end

    it 'should save successfully' do
      expect(session.save).to eq(true)
    end
    
  end
end
