require 'spec_helper'

describe Category do
	it "has a valid factory" do
		expect(FactoryGirl.build(:category)).to be_valid
	end

	it "is valid with a name and order_type" do
		expect(Category.new(name: "test", order_type_id: 1)).to be_valid
	end

	it "is invalid without a name" do
		expect(Category.new(name: nil)).to have(1).errors_on(:name)
	end

	it "is invalid without an order_type" do
		expect(Category.new(order_type_id:nil)).to have(1).errors_on(:order_type_id)
	end
end
