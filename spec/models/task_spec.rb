require 'spec_helper'

describe Task do
	it "has a valid factory" do
		expect(FactoryGirl.build(:task)).to be_valid
	end
  
  it "must have a description" do
    expect(Task.create.errors.messages[:description]).to eq ["can't be blank"]
  end

  it "must have a category" do
    expect(Task.create.errors.messages[:category]).to eq ["can't be blank"]
  end


end
