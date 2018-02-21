require 'spec_helper'

describe Validation do

  it "must have a valid error factory" do
    expect(build(:validation, :has_error)).to be_valid
  end

  it "must have a valid no error factory" do
    expect(build(:validation, :has_error)).to be_valid
  end
  
  describe "relationship entry" do
    it "must include an order" do

      expect(Validation.create(order: nil).errors.messages[:order]).to eq ["can't be blank"]
    end
      
    it "must include a task" do
      expect(Validation.create(order: nil).errors.messages[:task_id]).to eq ["can't be blank"]
    end

    it "must be unique" do
      order = create(:order)
      task = create(:task)
      v1 = Validation.create(approval:false, order: order, task: task)
      v2 = Validation.create(approval:false, order: order, task: task)
      expect {v2.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Order has already been taken, Task has already been taken')
    end
  end
  
  it "must include a validation" do
    expect(Validation.create(order: nil).errors.messages[:approval]).to eq ["is not included in the list"]
  end    
end

