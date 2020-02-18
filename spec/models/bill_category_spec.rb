# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillCategory, type: :model do
  describe 'Validations' do
    let(:bill_category) { build(:bill_category) }

    it 'is valid with valid attributes' do
      expect(bill_category).to be_valid
    end

    it 'should save successfully' do
      expect(bill_category.save).to eq(true)
    end

    it { should belong_to(:bill) }

    it { should belong_to(:category) }
  end
end
