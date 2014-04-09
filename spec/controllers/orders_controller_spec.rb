require "spec_helper"

describe OrdersController do

	describe "GET #index" do
		it "redirects to the current day of orders"
	end

	describe "GET dates" do
		describe "date parameters" do
			describe ":year" do
				context "when invalid" do
					it "@date assigns to current year"
					it "flash message 'Invalid Date'"
				end
				context "when valid" do
					it "@date assigns year if valid"
				end
			end
			describe ":month" do
				context "when invalid" do
					it "@date assigns to current month"
					it "flash message 'Invalid Date'"
				end
				context "when valid" do
					it "@date assigns month if valid"
				end
			end
			describe ":day" do
				context "when invalid" do
					it "@date assigns to current day"
					it "flash message 'Invalid Date'"
				end
				context "when valid" do
					it "@date assigns year if valid"
				end
			end
		end
		describe "#show_day" do
			it 'renders :day template'
			it 'collects orders by order_type for that day'
			it 'date parameters return correct time range'
		end
		describe "#show_month" do
			describe "with valid params" do
				it 'renders :month template'
				it 'date parameters return time range for orders'
				it 'collects orders by month'
				it 'groups orders by day'
				context 'breakdown method' do
					it 'organizes order data for chart'
					it 'initialze gon variable for javascript'
				end
			end
		end
		describe "#show_year" do
			it 'redirects to archive for current year'
			it 'renders :archive template'
		end
	end

	describe "GET #new" do
		it "renders the :new template"
		describe "associations/nested attributes" do
			it "builds new validation data"
		end
	end

	describe "POST #create" do
		context "if successful" do
			it "saves order"
			it "redirects to #show_day w/ order.created_at.day"
			context "validations" do
				it "saves new validations"
				it "validations.count == order_type.tasks.count"
				it "order.tasks == order_type.tasks"
			end
		end
		context "IF errors" do
			it "does not save order"
			it "renders :new template"
			it "shows form errors"
		end
	end
	
	describe "PUT #update" do
		context "IF successful" do
			it "saves order"
			it "redirects #show_day w/ order.created_at.day"
			describe "validations" do
				context "error status" do
					it "if changed to true returns false"
					it "if changed to false returns true"
					context "validates order.errors?" do
						it "if errors present changes to true"
						it "if errors n/a changes to false"
					end
				end
				it "validations.count == order_type.tasks.count"
				it "order.tasks == order_type.tasks"
			end
		end
		context "IF errors" do 
			it "does not save order"
			it "renders :edit template"
			it "shows form errors"
		end
	end

	describe "GET #edit" do
		it "renders :edit template"
		describe "associations/nested attributes" do
			it "loads current validation data"
		end
	end

	describe "DELETE #destroy" do
		context "if successful" do
			it "deletes order"
			it "deletes nested validation attributes"
			it "does not destroy other validations"
			it "does not destroy tasks"
		end
	end

end