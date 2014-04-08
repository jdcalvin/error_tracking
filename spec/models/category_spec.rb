require 'spec_helper'

describe Category do
	it "has a valid factory" do
		expect(FactoryGirl.build(:category)).to be_valid
	end
	it "is valid with a name and order_type" do
		expect(Category.new(name: "test", order_type: build(:order_type))).to be_valid
	end
	it "is invalid without a name" do
		expect(build(:category, name: nil)).to have(1).errors_on(:name)
	end

	it "is invalid without an order_type" do
		expect(build(:category, order_type:nil)).to have(1).errors_on(:order_type)
	end

	it "capitalizes full name before save" do
		expect(create(:category, name: "test name").name).to eq 'Test Name'
	end

end
