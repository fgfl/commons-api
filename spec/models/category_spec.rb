# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Validations' do
    let(:category) { build(:random_category) }
    let(:category2) { build(:random_category) }

    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category.name = nil
      expect(category).to_not be_valid
    end

    it 'is not valid without a uclassify_class' do
      category.uclassify_class = nil
      expect(category).to_not be_valid
    end

    it 'is not valid if name is not unique' do
      category2.name = category.name
      category2.save
      expect(category).to_not be_valid
    end

    it 'is not valid if uclassify_class is not unique' do
      category2.uclassify_class = category.uclassify_class
      category2.save
      expect(category).to_not be_valid
    end

    it 'should save successfully' do
      expect(category.save).to eq(true)
    end
  end
end
