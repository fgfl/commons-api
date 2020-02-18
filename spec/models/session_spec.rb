# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Session, type: :model do
  describe 'Validations' do
    let(:session) { build(:random_session) }

    it 'is valid with valid attributes' do
      expect(session).to be_valid
    end

    it 'is valid if the start_date is a Date object' do
      session.start_date = Faker::Date.backward(days: 365)
      expect(session).to be_valid
    end

    it 'is valid if the end_date is a Date object' do
      session.end_date = Faker::Date.forward(days: 365)
      expect(session).to be_valid
    end

    it 'is not valid without a start_date' do
      session.start_date = nil
      expect(session).to_not be_valid
    end

    it 'is not valid if the start_date is not a Date object' do
      session.start_date = 'string'
      expect(session).to_not be_valid
    end

    it 'is not valid if start_date is not in the past' do
      session.start_date = Faker::Date.forward(days: 365)
      expect(session).to_not be_valid
    end

    it 'is not valid if end_date is not in the future' do
      session.end_date = Faker::Date.backward(days: 365)
      expect(session).to_not be_valid
    end

    it 'should save successfully' do
      expect(session.save).to eq(true)
    end
  end
end
