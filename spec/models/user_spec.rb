require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "valid user is created" do
      @user = User.new(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "me@strange.com", 
                        password: "testing",
                        password_confirmation: "testing",
                        created_at: DateTime.now, updated_at: DateTime.now)
      expect(@user).to be_valid
      # expect(@user.errors.full_messages.first).to include("can't be blank")
    end

    it "password and confirmation don't match" do
      @user = User.new(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "me@strange.com", 
                        password: "testing",
                        password_confirmation: "testin",
                        created_at: DateTime.now, updated_at: DateTime.now)
      expect(@user).to be_invalid
      expect(@user.errors[:password_confirmation].first).to include("doesn't match Password")
    end

    it "no password" do
      @user = User.new(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "me@strange.com", 
                        password: nil,
                        password_confirmation: "testin",
                        created_at: DateTime.now, updated_at: DateTime.now)
      expect(@user).to be_invalid
      expect(@user.errors[:password_confirmation].first).to include("doesn't match")
    end

    it "unique emails" do
      @user = User.create(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "me@strange.com", 
                        password: "testing",
                        password_confirmation: "testing",
                        created_at: DateTime.now, updated_at: DateTime.now)
      expect(@user).to be_valid
      
      @cap_user = User.new(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "ME@STRANGE.COM", 
                        password: "testing",
                        password_confirmation: "testing",
                        created_at: DateTime.now, updated_at: DateTime.now)

      expect(@cap_user).to be_invalid
      expect(@cap_user.errors[:email]).to include("has already been taken")
    end

    it "password minimum length" do
      @user = User.new(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "ME@STRANGE.COM", 
                        password: "tes",
                        password_confirmation: "tes",
                        created_at: DateTime.now, updated_at: DateTime.now)

      expect(@user).to be_invalid
      expect(@user.errors[:password].first).to include("is too short")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'can be found with space' do
      @user = User.create(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "ME@STRANGE.COM", 
                        password: "testing",
                        password_confirmation: "testing",
                        created_at: DateTime.now, updated_at: DateTime.now)

      expect(@user).to be_valid
      
      expect(User.authenticate_with_credentials(" ME@STRANGE.COM ", "testing")).to be_a User
    end

    it 'can be found with different case' do
      @user = User.create(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "ME@STRANGE.COM", 
                        password: "testing",
                        password_confirmation: "testing",
                        created_at: DateTime.now, updated_at: DateTime.now)

      expect(@user).to be_valid
      
      expect(User.authenticate_with_credentials(" me@STRANGE.COM ", "testing")).to be_a User
    end
  end
end
