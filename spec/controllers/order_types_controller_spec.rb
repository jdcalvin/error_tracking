require 'spec_helper'

describe OrderTypesController do
		let(:user) {FactoryGirl.create(:admin)}
		before{sign_in user}


	it 'should have a current user' do
		user.should_not be_nil
	end

	describe 'GET #index' do
		before :each do 
			@organization = FactoryGirl.create(:organization)
			@order_type = FactoryGirl.create(:order_type, :organization => @organization)
		end
		it 'redirects to organization' do
			get :index
			expect(response).to redirect_to organization_path(assigns(:organization))
		end
	end

	describe 'GET #show' do
		it 'renders :show template' do
			order_type = FactoryGirl.create(:order_type)
			get :show, id: order_type
			expect(response).to render_template :show
		end
		it 'assigns params to @order_type' do
			order_type = FactoryGirl.create(:order_type)
			get :show, id: order_type
			expect(assigns(:order_type)).to eq order_type
		end
	end
	describe 'GET #new' do
		it 'renders :new template' do
			get :new
			expect(response).to render_template :new
		end

		it 'assigns a new OrderType to @order_type' do
			get :new
			expect(assigns(:order_type)).to be_a_new(OrderType)
		end
	end
	describe 'POST #create' do
		before :each do
			@organization = user.organization
		end
		context 'IF valid' do
			it 'saves order_type' do
				expect do
					xhr :post, :create, order_type: attributes_for(:order_type, :organization_id => @organization.id, 
					categories_attributes: [attributes_for(:category, 
						tasks_attributes: [attributes_for(:task)])])
				end.to change(OrderType, :count).by(1)
			end
			it 'redirects to order_type' do	
				xhr :post, :create, order_type: attributes_for(:order_type, :organization_id => @organization.id, 
					categories_attributes: [attributes_for(:category, 
						tasks_attributes: [attributes_for(:task)])])
				expect(response).to redirect_to order_type_path(assigns[:order_type])
			end
			
			context 'nested category attributes' do
				it 'created and assigned to order_type'
				context 'nested task attributes' do
					it 'created and assigned to categories'
				end
			end
		end
		context 'IF invalid' do
			it 'does not save order_type'
			it 'shows errors'
			it 're-renders :new template'
			context 'nested category attributes' do
				it 'are not created'
				context 'nested task attributes' do
					it 'are not created'
				end
			end
		end
	end
	describe 'GET #edit' do
		it 'renders :edit template'
	end
	describe 'PUT #update' do
		context 'IF valid' do
			it 'saves order_type'
			it 'redirects to order_type'
			context 'nested category attributes' do
				it 'if saved reflect changes'
				it 'if destroyed reflect changes'
				context 'nested task attributes' do
					it 'if saved reflect changes'
					it 'if destroyed reflect changes'
				end
			end
		end
		context 'IF invalid' do
			it 'does not save order_type'
			it 'shows errors'
			it 're-renders :new template'
			context 'nested category attributes' do
				it 'are not created'
				context 'nested task attributes' do
					it 'are not created'
				end
			end
		end
	end
	describe 'DELETE #destroy' do
		it 'destroys order_type'
		it 'destroys orders'
		it 'destroys tasks'
		it 'destroys categories'
		it 'destroys validations'
	end
	
end