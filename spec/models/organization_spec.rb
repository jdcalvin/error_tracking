require 'spec_helper'

describe Organization do
	it "has a valid factory" do
		expect(FactoryBot.build(:organization)).to be_valid
	end

	it "is invalid without a title" do
		expect(Organization.create.errors.messages[:title]).to eq ["can't be blank"]
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
