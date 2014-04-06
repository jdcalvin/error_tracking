require 'spec_helper'

describe OrderType do

	it "has a valid factory" do
		expect(FactoryGirl.build(:order_type)).to be_valid
	end

	org_type = Organization.create(title:"blah")
	it "is invalid without an organization" do
		expect(OrderType.new(organization_id: nil)).to have(1).errors_on(:organization_id)
	end

	it "is invalid without a title" do
		expect(OrderType.new(title: nil)).to have(1).errors_on(:title)
	end

	it "is valid with an organization and title" do
		expect(OrderType.new(title:"test", organization_id: 1)).to be_valid
	end

	describe "title" do
		org = Organization.create(title:"test")
		type = org.order_types.create(title:"test type")
		it "capitalizes before saving" do
			expect(type.title).to eq "Test Type"
		end
	end
end

