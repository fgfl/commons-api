# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBill, type: :model do
  describe 'Validations' do
    let(:user_bill) { build(:user_bill) }

    it 'is valid with valid attributes' do
      pp user_bill
      expect(user_bill).to be_valid
    end

    # it "should save successfully" do
    #   expect(user_bill.save).to eq(true)
    # end

    it { should belong_to(:user) }

    it { should belong_to(:bill) }
  end
end
