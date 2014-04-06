require 'spec_helper'

describe Validation do
	it "has a valid error factory" do
		expect(build(:validation, :has_error)).to be_valid
	end

	it "has a valid no_error factory" do
		expect(build(:validation, :no_error)).to be_valid
	end

  describe "relationship" do
    it "must include an order" do
      expect(Validation.new(order_id: nil)).to have(1).errors_on(:order_id)
    end
      
    it "must include a task" do
      expect(Validation.new(task_id: nil)).to have(1).errors_on(:task_id)
    end

    it "must be unique" do
      order = create(:order)
      task = create(:task)
      v1 = create(:validation, :has_error, order: order, task: task)
      v2 = build(:validation, :has_error, order: order, task: task)

      expect {v2.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Order has already been taken, Task has already been taken')
    end
  end
  
  it "must include a validation" do
    expect(build(:validation, approval: nil)).to have(1).errors_on(:approval)
  end    
end

