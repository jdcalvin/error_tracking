require 'spec_helper'

describe Order do
	it "has a valid factory" do
		expect(build(:order)).to be_valid
	end

	it "is invalid without an order_name" do
		expect(Order.new(order_name: nil)).to have(1).errors_on(:order_name)
	end
	it "is invalid without an order_type" do
		expect(Order.new(order_type: nil)).to have(1).errors_on(:order_type)
	end
	it "is invalid without a user" do
		expect(Order.new(user:nil)).to have(1).errors_on(:user)
	end
	it "is valid with user, order_type, and order_name" do
		expect(build(:order, order_type: build(:order_type), user: build(:user))).to be_valid
	end

  it "has valid template associations" do
    order_type = create(:order_type)
    order = create(:order, :no_error, :order_type => order_type)
    expect(order.tasks == order_type.tasks).to eq true
  end

  describe "with errors" do  		
  	order = FactoryGirl.create(:order, :with_error)

    it "status should return true" do
      expect(order.error).to eq true
    end
    it "note is required" do
    	expect(build(:order, :with_error, note: nil)).to have(1).errors_on(:note)
    end
    it "checks validations for errors" do
    	expect(order.errors?).to eq true
    end
  end
  describe "without errors" do
  	order = FactoryGirl.create(:order, :no_error)

    it "status should return false" do
      expect(order.error).to eq false
    end
    it "note isn't required" do
    	expect(build(:order, note:nil)).to be_valid
    end
    it "checks validations for errors" do
    	expect(order.errors?).to eq false
    end
  end
end
