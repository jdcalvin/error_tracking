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
		expect(build(:order, user: nil)).to have(1).errors_on(:user)
	end
	it "is valid with user, order_type, and order_name" do
		expect(build(:order, order_type: build(:order_type), user: build(:user))).to be_valid
	end
  
  describe "with errors" do  		
    it "status should return true" do
      expect(build(:order, :with_error).error).to eq true
    end

    it "note is required" do
 			expect(build(:order, :with_error, note: nil)).to have(1).errors_on(:note)
    end
  end
  describe "without errors" do
    it "status should return false" do
      expect(build(:order).error).to eq false
    end
    it "note isn't required" do
    	expect(build(:order, note:nil)).to be_valid
    end
  end
end
