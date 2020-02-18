# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  describe 'Validations' do
    let(:user_category) { build(:user_category) }

    it 'is valid with valid attributes' do
      pp user_category
      expect(user_category).to be_valid
    end

    # it "should save successfully" do
    #   expect(user_category.save).to eq(true)
    # end

    it { should belong_to(:user) }

    it { should belong_to(:category) }
  end
end
