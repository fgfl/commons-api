require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject {
      User.new( email: "gerald@dogs.com", 
                name: "Gerald", 
                password: "dogsrule", 
                password_confirmation: "dogsrule",
              )
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end
end
