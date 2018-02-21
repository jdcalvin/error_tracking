require 'spec_helper'

describe User do

  describe "factory" do

    it "builds valid user" do
      expect(build(:user)).to be_valid
    end

    it "builds valid admin" do
      expect(build(:admin).admin).to eq true
    end

    it "builds valid inactive user" do
      expect(build(:inactive).active).to eq false
    end
  end

  it "is valid with a firstname, lastname, email, and password" do
    expect(User.new(first_name:"test", last_name:"user", 
                    email:"testing@email.com", password:"password"))
    .to be_valid
  end

  it "is invalid without a first_name" do
    expect(User.create.errors.messages[:first_name]).to eq ["can't be blank"]
  end

  it 'is invalid without a last_name' do
    expect(User.create.errors.messages[:last_name]).to eq ["can't be blank"]
  end

  it "is invalid without an email" do
    expect(User.create.errors.messages[:email]).to eq ["can't be blank"]
  end

  it "must have a unique email address" do
    user = FactoryGirl.create(:user)
    expect(User.create(email: user.email).errors.messages[:email]).to eq ["has already been taken"]
  end

  it "is invalid without a password" do
    expect(User.create.errors.messages[:password]).to eq ["can't be blank"]
  end

  it "must have a valid email address" do
    expect(User.create(email: 'sdfsdfsdf').errors.messages[:email]).to eq ["is invalid"]
  end

  it "capitalizes name before saving" do
    expect(create(:user, first_name: 'test', last_name: 'user').full_name).to eq 'Test User'
  end

  describe "password" do
    context "character length" do
      it "is invalid when less than 8 " do
        expect(User.create(password: 'pass').errors.messages[:password]).to eq ["is too short (minimum is 6 characters)"]
      end

      it "is valid when at least 8" do
        expect(User.create(password: 'password').errors.messages[:password]).to eq nil
      end
    end
  end
end
