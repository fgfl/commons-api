require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject {
      User.new( name: "Gerald", 
                username: "Link45",
                password: "dogsrule", 
                password_confirmation: "dogsrule",
                email: "gerald@dogs.com"
              )
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a name" do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password_confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if password and password_confirmation do not match" do
      subject.password = "dogsrule"
      subject.password_confirmation = "catsrule"
      expect(subject).to_not be_valid
    end
    
    it "is not valid unless password is at least 5 characters" do
      subject.password = "1234"
      expect(subject).to_not be_valid
    end
    
    it { should validate_uniqueness_of(:email) }
    
  end
end
