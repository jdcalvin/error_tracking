require 'spec_helper'

describe Tracking::ErrorBreakdown do
  describe "show_errors" do
    let(:order){TestOrders.new.create_order_with_errors_on('A-1','B-2','B-3')}
    it 'returns list of errors' do
      expect(described_class.by_order(order)).to eq (
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
      expect(described_class.by_orders(test_orders.all_orders)).to eq(
        {
          "A" => {"A-1"=>2, "A-2"=>1},
          "B" => {"B-2"=>2, "B-3"=>2, "B-1"=>1},
        })
    end
  end
end