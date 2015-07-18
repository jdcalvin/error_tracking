require 'spec_helper'

describe Order do
	it "has a valid factory" do
		expect(build(:order)).to be_valid
	end

	it "is invalid without an order_name" do
		expect(Order.create.errors.messages[:order_name]).to eq ["can't be blank"]
	end
	it "is invalid without an order_type" do
		expect(Order.create.errors.messages[:order_type]).to eq ["can't be blank"]
	end
	it "is invalid without a user" do
		expect(Order.create.errors.messages[:user]).to eq ["can't be blank"]
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
    	expect(Order.create(error:true).errors.messages[:note]).to eq ["can't be empty if errors are present"]
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


  describe "show_errors" do
    it 'returns list of errors' do
      expect(TestOrders.new.create_order_with_errors_on('A-1','B-2','B-3').show_errors).to eq (
        {
          "A" => ["A-1"],
          "B" => ["B-2", "B-3"],
        })
    end
  end

  describe "breakdown" do
    let!(:test_orders)  {TestOrders.new}

    before do
      test_orders.create_order_with_errors_on('A-1','B-2')
      test_orders.create_order_with_errors_on('A-1','B-2','B-3')
      test_orders.create_order_without_errors
      test_orders.create_order_with_errors_on('A-2','B-1','B-3')
    end

    it 'displays count of errors on order_type' do
      expect(test_orders.all_orders.breakdown).to eq(
        {
          "A" => {"A-1"=>2, "A-2"=>1},
          "B" => {"B-2"=>2, "B-3"=>2, "B-1"=>1},
        })
    end
  end

end
