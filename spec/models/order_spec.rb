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
		expect(build(:order, :with_error)).to be_valid
	end

  it "has valid template associations" do
    order_type = create(:order_type)
    order = create(:order, :no_error, :order_type => order_type)
    expect(order.tasks.count == order_type.tasks.count).to eq true
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

  describe "search method" do
    before :each do
    order1 = FactoryGirl.create(:order, order_name: 'testing1')
    order2 = FactoryGirl.create(:order, order_name: 'testing2')
    order3 = FactoryGirl.create(:order, order_name: 'testing3')
    end
    it 'returns specific search criteria' do
      expect(Order.search("testing1").count).to eq 1
    end
    it 'returns broad search criteria' do
      expect(Order.search("testing").count).to eq 3
    end
  end
end
