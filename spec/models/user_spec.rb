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
    expect(build(:user, first_name: nil)).to have(1).errors_on(:first_name)
  end
  it 'is invalid without a last_name' do
    expect(build(:user, last_name: nil)).to have(1).errors_on(:last_name)
  end
  it "is invalid without an email" do
    expect(build(:user, email: nil)).to have(1).errors_on(:email)
  end
  it "must have a unique email address" do
    user = FactoryGirl.create(:user)
    expect(User.new(email: user.email)).to have(1).errors_on(:email)
  end
  it "is invalid without a password" do
    expect(build(:user, password: nil)).to have(1).errors_on(:password)
  end
  it "must have a valid email address" do
    expect(User.new(email: 'sdfsfd')).to have(1).errors_on(:email)
  end
  it "capitalizes name before saving" do
    expect(create(:user, first_name: 'test', last_name: 'user').full_name).to eq 'Test User'
  end

  describe "password" do
    context "character length" do
      it "is invalid when less than 8 " do
        expect(User.new(password: "pass")).to have(1).errors_on(:password)
      end
      it "is valid when at least 8" do
        expect(User.new(password: "password")).to have(0).errors_on(:password)
      end
    end
  end
end
