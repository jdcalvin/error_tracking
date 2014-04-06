require 'spec_helper'

describe Organization do
	it "has a valid factory" do
		expect(FactoryGirl.build(:organization)).to be_valid
	end

	it "is invalid without a title" do
		expect(Organization.new(title:nil)).to have(1).errors_on(:title)
	end

	it "is valid with a title" do
		expect(Organization.new(title: "test title")).to be_valid
	end

	describe "title" do
		org = Organization.create(title:"test org")
		it "capitalizes before saving" do
			expect(org.title).to eq "Test Org"
		end
	end
end
