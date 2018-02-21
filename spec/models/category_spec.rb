require 'spec_helper'

describe Category do
	it "has a valid factory" do
		expect(FactoryGirl.build(:category)).to be_valid
	end
	
	it "is valid with a name and order_type" do
		expect(Category.new(name: "test", order_type: build(:order_type))).to be_valid
	end
	
	it "is invalid without a name" do
		expect(Category.create.errors.messages[:name]).to eq ["can't be blank"]
	end

	it "is invalid without an order_type" do
		expect(Category.create.errors.messages[:order_type]).to eq ["can't be blank"]
	end

	it "capitalizes full name before save" do
		expect(create(:category, name: "test name").name).to eq 'Test Name'
	end

end
