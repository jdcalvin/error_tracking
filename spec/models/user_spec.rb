require 'spec_helper'

describe User do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  user1 = User.create(first_name: 'Test', last_name: 'User',
                  email: 'test1@test.com', password: 'password')
  user2 = User.new(first_name: 'User', last_name: 'Test',
                  email: 'test2@test.com', password: 'password')
  user_nil = User.new

  it "is valid with a firstname, lastname, email, and password" do
    expect(User.new(first_name:"test", last_name:"user", 
                    email:"testing@email.com", password:"password"))
    .to be_valid
  end
  it "is invalid without a first_name" do
    expect(user_nil).to have(1).errors_on(:first_name)
  end
  it 'is invalid without a last_name' do
    expect(user_nil).to have(1).errors_on(:last_name)
  end
  it "is invalid without an email" do
    expect(user_nil).to have(1).errors_on(:email)
  end
  it "must have a unique email address" do
    expect(User.new(email: user1.email)).to have(1).errors_on(:email)
  end
  it "is invalid without a password" do
    expect(user_nil).to have(1).errors_on(:password)
  end
  it "must have a valid email address" do
    expect(User.new(email: 'sdfsfd')).to have(1).errors_on(:email)
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
