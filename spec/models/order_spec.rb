require 'spec_helper'

describe Order do
	it "has a valid factory" do
		expect(FactoryGirl.build(:order)).to be_valid
	end
	org = Organization.create(title: "test_org")
	type = org.order_types.create(title:"test")
	user = org.users.create(first_name:"test", last_name:"user", 
													password:"password", email:"email1@email.com")
	order1 = type.orders.create(order_name:"test", user_id: 1)

	it "is invalid without an order_name" do
		expect(Order.new(order_name: nil)).to have(1).errors_on(:order_name)
	end
	it "is invalid without an order_type" do
		expect(Order.new(order_type: nil)).to have(1).errors_on(:order_type)
	end
	it "is invalid without a user" do
		expect(Order.new(user: nil)).to have(1).errors_on(:user)
	end
	it "is valid with user, order_type, and order_name" do
		expect(order1).to be_valid
	end


end
