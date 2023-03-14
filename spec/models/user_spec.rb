require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do 
    @user = User.create(name: 'Molly David', email: "123@molly.com", password:'123Unicorns!', password_confirmation:'123Unicorns!')
  end

  describe 'Validations' do
    # validation examples here

    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end

    it "is not valid passwords do not match" do
      @user.password_confirmation = '1234'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "has a valid password" do
      @user= User.new(name: "Molly David", email: '123@molly.com', password:"", password_confirmation: "")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "has a unique email" do
      @user1= User.create(name: 'Molly David', email: '123@mollly.com', password:'123Unicorns!', password_confirmation:'123Unicorns!')
      @user2= User.create(name: 'Molly David', email: '123@MOLLLY.COM', password:'123Unicorns!', password_confirmation:'123Unicorns!')
      @user1.email = @user2.email
      expect(@user1).to be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "is not valid without a name" do
      @user.name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "is not long enough of password" do
      @user1= User.create(name: 'Maryan Jason', email: '123@mary.com', password:'123!', password_confirmation:'123!') 
      expect(@user1).to_not be_valid
      expect(@user1.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end


  describe '.authenticate_with_credentials' do

    it "returns user object for valid email and password" do 
      result = User.authenticate_with_credentials("123@molly.com", "123Unicorns!")
      expect(result).not_to be_nil
      expect(result).to be_a User
    end

    it "returns nil for invalid email " do 
      result = User.authenticate_with_credentials("12345@mary.com", "12345Unicorns!")
      expect(result).to be_nil
    end
    
    it "returns nil for invalid password" do 
      result = User.authenticate_with_credentials("123@molly.com", "12345Unicorns!")
      expect(result).to be_nil
    end

    #####  EDGE CASES  ########
    it "returns user object for email with spaces" do 
      result = User.authenticate_with_credentials("  123@molly.com", "123Unicorns!")
      expect(result).not_to be_nil
      expect(result).to be_a User
    end

    it "returns user object for email with wrong casing" do 
      result = User.authenticate_with_credentials("123@MoLLy.com", "123Unicorns!")
      expect(result).not_to be_nil
      expect(result).to be_a User
    end



  end

end
