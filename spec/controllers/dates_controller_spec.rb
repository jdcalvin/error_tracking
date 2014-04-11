require 'spec_helper'

describe DatesController do
	let(:user) {FactoryGirl.create(:admin)}
	before :each do
		sign_in user
		@order_type = FactoryGirl.create(:order_type, :organization => user.organization)
	end
	
	describe "GET #show_year" do
		it 'redirects to archive for current year'
		it 'renders :archive template'
	end
	
	describe "GET #show_month" do

		it 'renders the :show_month template'
		it 'date parameters return correct time range for orders'
		it 'collects orders by month'
		it 'groups orders by day'
		context 'breakdown method' do
			it 'organizes order data for chart'
			it 'initialze gon variable for javascript'
		end
		context "when invalid" do
			it "@date assigns to current month"
			it "flash message 'Invalid Date'"
		end
		context "when valid" do
			it "@date assigns month if valid"
		end
	end

	describe "GET #show_day" do

		it 'renders the :show_day template'
		it 'date parameters return correct time range for orders'
		it 'collects orders by order_type for that day'
		context "when invalid" do
			it "@date assigns to current day"
			it "flash message 'Invalid Date'"
		end
		context "when valid" do
			it "@date assigns year if valid"
		end
	end

end