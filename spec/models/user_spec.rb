require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    let(:user) { build(:random_user) }
    
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a name" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a name" do
      user.username = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a password_confirmation" do
      user.password_confirmation = nil
      expect(user).to_not be_valid
    end

    it "is not valid if password and password_confirmation do not match" do
      user.password_confirmation = 'wordpass'
      expect(user).to_not be_valid
    end
    
    it "is not valid unless password is at least 5 characters" do
      user.password = "1234"
      expect(user).to_not be_valid
    end
    
    it { should validate_uniqueness_of(:email) }

    it 'should save successfully' do
      expect(user.save).to eq(true)
    end
    
  end

end
