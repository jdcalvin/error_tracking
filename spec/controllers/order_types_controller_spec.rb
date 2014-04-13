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
		end
		context 'IF invalid' do
			it 'does not save order_type' do
				expect do
					xhr :post, :create, order_type: attributes_for(:invalid_order_type)
				end.to change(OrderType, :count).by(0)
			end
			it 'shows errors' do
				@type = FactoryGirl.build(:invalid_order_type)
				@type.valid?
				@type.errors.messages[:title].should include("can't be blank")
			end

			it 're-renders :new template' do
				xhr :post, :create, order_type: attributes_for(:invalid_order_type)
				expect(response).to render_template :new
			end
		end
	end
	describe 'GET #edit' do
		it 'renders :edit template' do
		order_type = FactoryGirl.create(:order_type)
			get :edit, id: order_type
			expect(assigns[:order_type]).to eq order_type
		end
	end
	describe 'PATCH #update' do
		before :each do
			@order_type = FactoryGirl.create(:order_type, title: "Type Active")
		end
		context 'with valid attributes' do
			it 'locates the requested resource' do
				patch :update, id: @order_type, order_type: attributes_for(:order_type)
				expect(assigns(:order_type)).to eq(@order_type)
			end
			it 'saves order_type' do
				patch :update, id: @order_type, order_type: attributes_for(:order_type, title: 'Spec Test')
				@order_type.reload
				expect(@order_type.title).to_not eq nil
				expect(@order_type.title).to eq "Spec Test"
			end
			it 'redirects to order_type' do
				patch :update, id: @order_type, order_type: attributes_for(:order_type)
				expect(response).to redirect_to order_type_path(@order_type)
			end

		end
		context 'with invalid attributes' do
			it 'does not save order_type' do
				patch :update, id: @order_type, order_type: attributes_for(:order_type, title: nil)
				@order_type.reload
				expect(@order_type.title).to_not eq nil
				expect(@order_type.title).to eq "Type Active"
			end
			it 'shows errors' do
				@order_type.update_attributes(title: nil)
				@order_type.valid?
				@order_type.errors.messages[:title].should include("can't be blank")
			end
			it 're-renders :edit template' do
				patch :update, id: @order_type, order_type: attributes_for(:order_type, title:nil)
				expect(response).to render_template :edit
			end
		end
	end
	describe 'DELETE #destroy' do
		before :each do
			@organization = FactoryGirl.create(:organization)
			@order_type = FactoryGirl.create(:order_type, organization: @organization)
			@orders = [FactoryGirl.create(:order, :no_error, :order_type => @order_type),
				FactoryGirl.create(:order, :no_error, :order_type => @order_type)]
			@categories = @order_type.categories
			@tasks = @order_type.tasks
			@validations = @order_type.validations
		end
		it 'destroys order_type' do
			expect do
				xhr :delete, :destroy, id: @order_type
			end.to change(OrderType, :count).by(-1)
		end
		it 'destroys orders' do
			expect(@order_type == @orders.first.order_type)
		end
		it 'destroys tasks' do
			expect do
				xhr :delete, :destroy, id: @order_type
			end.to change(@tasks, :count).to(0)
		end
		it 'destroys categories' do
			expect do
				xhr :delete, :destroy, id: @order_type
			end.to change(@categories, :count).to(0)
		end
		it 'destroys validations' do
			expect do
				xhr :delete, :destroy, id: @order_type
			end.to change(@validations, :count).to (0)
		end
	end
	
end