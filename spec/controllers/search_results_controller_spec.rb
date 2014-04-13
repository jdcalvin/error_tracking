require 'spec_helper'

describe SearchResultsController do
	let(:user) {FactoryGirl.create(:admin)}
	before{sign_in user}

	describe 'GET #search' do
		it 'renders :search' do
			get :search, search: 'test'
			expect(response).to render_template :search
		end

		it 'redirects if search params are empty' do
			get :search, search: nil
			expect(response).to redirect_to root_path
		end
		it 'scopes searches to current organization' do
			@organization = FactoryGirl.create(:organization)
			@alt_user = FactoryGirl.create(:user, :organization => @organization)
			@order = FactoryGirl.create(:order, :no_error, order_name: "test", :user => @alt_user)
			get :search, search: "test"
			expect(response).to_not include(@order)
		end
	end

end
