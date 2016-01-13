require 'spec_helper'

describe DatesController do
	let(:user) {FactoryGirl.create(:admin)}
	before :each do
		sign_in user
		@order_type = FactoryGirl.create(:order_type, :organization => user.organization)
		@url = "/order_types/#{@order_type.id}"
	end

	before do
		allow_any_instance_of(::DatesController).to receive(:gon_data){nil}
		allow_any_instance_of(::DatesController).to receive(:clear_gon){nil}
	end
	
	let (:controller) {DatesController.new}

	describe "GET #show_year" do
		xit 'renders the :archive template' do
			get :show_year, order_type_id: @order_type.id, year: 2014
			expect(response).to redirect_to("#{@url}/archive")
		end
	
		it 'routes to correct year' do
			expect(:get => "#{@url}/date/2014").to route_to(
				:controller => "dates",
				:action => "show_year",
				:order_type_id => @order_type.id.to_s,
				:year => '2014')
		end
	end

	describe "GET #show_month" do
		xit 'routes to correct month' do
			get :show_month, order_type_id: @order_type.id, month: 2, year: 2014
			expect(response).to render_template :show_month
		end
		it 'routes to correct month' do
			expect(:get => "#{@url}/date/2014/5").to route_to(
				:controller => "dates",
				:action => "show_month",
				:order_type_id => @order_type.id.to_s,
				:year => '2014',
				:month => '5')
		end

	end

	describe "GET #show_day" do

		xit 'renders the :show_day template' do
			get :show_day, order_type_id: @order_type.id, day: 1, month:2, year: 2014
		end
		
		it 'routes to correct day' do
			expect(:get => "#{@url}/date/2014/5/13").to route_to(
				:controller => "dates",
				:action => "show_day",
				:order_type_id => @order_type.id.to_s,
				:year => '2014',
				:month => '5',
				:day => '13')
		end
	end

end
