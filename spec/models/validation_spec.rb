require 'spec_helper'

describe Validation do
	it "has a valid error factory" do
		expect(FactoryGirl.build(:validation, :has_error)).to be_valid
	end

	it "has a valid no_error factory" do
		expect(FactoryGirl.build(:validation, :no_error)).to be_valid
	end
end

