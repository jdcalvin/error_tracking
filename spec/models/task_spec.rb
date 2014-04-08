require 'spec_helper'

describe Task do
	it "has a valid factory" do
		expect(FactoryGirl.build(:task)).to be_valid
	end
  
  it "must have a description" do
    expect(build(:task, description: nil)).to have(1).errors_on(:description)
  end

  it "must have a category" do
    expect(build(:task, category: nil)).to have(1).errors_on(:category)
  end


end
