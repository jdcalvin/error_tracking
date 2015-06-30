require 'spec_helper'

describe OrderType do

	describe "factory" do

		it "is valid" do
			expect(build(:order_type)).to be_valid
		end

		it "recognizes categories" do
			expect(create(:order_type).categories.count).to eq 2
		end

		it "recognizes tasks through categories" do
			expect(create(:order_type).tasks.count).to eq 4
		end
	end


	org_type = Organization.create(title:"blah")
	it "is invalid without an organization" do
		expect(OrderType.create(organization_id: nil).errors.messages[:organization_id]).to eq ["can't be blank"]
	end

	it "is invalid without a title" do
		expect(OrderType.create(organization_id: nil).errors.messages[:title]).to eq ["can't be blank"]
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

