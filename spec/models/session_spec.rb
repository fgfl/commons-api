# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParliamentarySession, type: :model do
  describe 'Validations' do
    let(:parliamentary_session) { build(:random_parliamentary_session) }

    it 'is valid with valid attributes' do
      expect(parliamentary_session).to be_valid
    end

    it 'is valid if the start_date is a Date object' do
      parliamentary_session.start_date = Faker::Date.backward(days: 365)
      expect(parliamentary_session).to be_valid
    end

    it 'is valid if the end_date is a Date object' do
      parliamentary_session.end_date = Faker::Date.forward(days: 365)
      expect(parliamentary_session).to be_valid
    end

    it 'is not valid without a start_date' do
      parliamentary_session.start_date = nil
      expect(parliamentary_session).to_not be_valid
    end

    it 'is not valid if the start_date is not a Date object' do
      parliamentary_session.start_date = 'string'
      expect(parliamentary_session).to_not be_valid
    end

    it 'is not valid if start_date is not in the past' do
      parliamentary_session.start_date = Faker::Date.forward(days: 365)
      expect(parliamentary_session).to_not be_valid
    end

    it 'is not valid if end_date is not in the future' do
      parliamentary_session.end_date = Faker::Date.backward(days: 365)
      expect(parliamentary_session).to_not be_valid
    end

    it 'should save successfully' do
      expect(parliamentary_session.save).to eq(true)
    end
  end
end
