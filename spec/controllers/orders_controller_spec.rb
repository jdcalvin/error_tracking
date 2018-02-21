require "spec_helper"

describe OrdersController do
		let(:user) {FactoryBot.create(:admin)}
		before :each do
			sign_in user
			@order_type = FactoryBot.create(:order_type, :organization => user.organization)
		end
		
	describe "GET #index" do
		before{@date = Time.now.in_time_zone}
		it "redirects to the current day of orders" do
			get :index, order_type_id: @order_type.id
			expect(response).to redirect_to order_type_show_day_path(@order_type, @date.year, @date.month, @date.day)
		end
	end

	describe "GET #new" do
		it "renders the :new template" do
			get :new, {:order_type_id => @order_type.id}
			expect(response).to render_template :new
		end
		it 'assigns a new Order to @order' do
			get :new, {:order_type_id => @order_type.id}
			expect(assigns(:order)).to be_a_new(Order)
		end
	end

	describe "POST #create" do
		context "if successful" do 
			it "saves order" do 
				expect do
					xhr :post, :create, order_type_id: @order_type.id, order: attributes_for(:order, :no_error) 
				end.to change(Order, :count).by(1)
			end

			it "redirects to #show_day w/ order.created_at.day" do
				xhr :post, :create, order_type_id: @order_type.id, order: attributes_for(:order, :no_error) 
				expect(response).to redirect_to order_type_show_day_path(@order_type, 
					assigns[:order].created_at.year, assigns[:order].created_at.month, assigns[:order].created_at.day)
			end
		end

		context "IF errors" do
			it "does not save order" do
				expect do
					xhr :post, :create, order_type_id: @order_type.id, order: attributes_for(:order, :no_error, order_name: nil) 
				end.to change(Order, :count).by(0)
			end
			it "renders :new template" do
				xhr :post, :create, order_type_id: @order_type.id, order: attributes_for(:order, :no_error, order_name: nil) 
				expect(response).to render_template :new
			end
		end
	end
	
	describe "PATCH #update" do
		before :each do
			@order = FactoryBot.create(:order, :no_error, :user => user, :order_type => @order_type)
			@validation = @order.validations.find_by(task: @order_type.tasks.first)
		end

		context "IF successful" do
			it 'locates the requested resource' do
				patch :update, order_type_id: @order_type.id, id: @order, order: attributes_for(:order)
				expect(assigns(:order)).to eq(@order)
			end

			it "saves order" do
				patch :update, order_type_id: @order_type.id, id: @order, order: attributes_for(:order, order_name: "Spec Test")
				@order.reload
				expect(@order.order_name).to eq("Spec Test")
			end

			it "redirects #show_day w/ order.created_at.day" do 
				patch :update, order_type_id: @order_type.id, id: @order, order: attributes_for(:order)
				expect(response).to redirect_to order_type_show_day_path(@order_type, 
					@order.created_at.year, @order.created_at.month, @order.created_at.day)
			end

			describe "validations" do
				context "error status" do
					context "validates order.errors?" do
						it "if errors present changes to true" do
							@validation.update_attributes(approval:true)
							patch :update, order_type_id: @order_type.id, id: @order, 
							order: attributes_for(:order)
							@order.reload
							expect(@order.error).to eq true
						end

						it "if errors n/a changes to false" do
							@validation.update_attributes(approval:true)
							@order.reload
							expect(@order.errors?).to eq true
							@validation.update_attributes(approval:false)
							patch :update, order_type_id: @order_type.id, id: @order, 
							order: attributes_for(:order)
							@order.reload
							expect(@order.error).to eq false
						end
					end
				end

				it "validations.count == order_type.tasks.count" do
					expect(@order.validations.count).to eq @order_type.tasks.count
				end

				it "order.tasks == order_type.tasks" do
					expect(@order.tasks.count).to eq @order_type.tasks.count
				end
			end
		end

		context "IF errors" do 
			it "does not save order" do 
				patch :update, order_type_id: @order_type.id, id: @order, 
							order: attributes_for(:order, :order_name => nil)
				@order.reload
				expect(@order.order_name).to_not eq nil
			end

			it "renders :edit template" do
				patch :update, order_type_id: @order_type.id, id: @order, 
							order: attributes_for(:order, :order_name => nil)
				expect(response).to render_template :edit
			end

			it "shows form errors" do
				@order.update_attributes(order_name: nil)
				@order.valid?
				expect(@order.errors.messages[:order_name]).to include("can't be blank")
			end
		end
	end

	describe "GET #edit" do
		it "renders :edit template" do
			order = FactoryBot.create(:order, :order_type_id => @order_type.id)
			get :edit, :order_type_id => @order_type.id, id: order
			expect(response).to render_template :edit
		end

		it 'assigns params to order' do
			order = FactoryBot.create(:order, :order_type_id => @order_type.id)
			get :edit, :order_type_id => @order_type.id, id: order
			expect(assigns(:order)).to eq order
		end

		describe "associations/nested attributes" do
			it "loads current validation data" do
				order = FactoryBot.create(:order, :no_error, :user => user, :order_type_id => @order_type.id)
				get :edit, :order_type_id => @order_type.id, id: order
				expect(assigns(:order).validations.count).to eq order.validations.count
			end
		end
	end

	describe "DELETE #destroy" do
		before :each do
			@order = FactoryBot.create(:order, :no_error, :user => user, :order_type_id => @order_type.id)
		end

		context "if successful" do
			it "deletes order" do
				expect do
					xhr :delete, :destroy, :order_type_id => @order_type.id, id: @order
				end.to change(Order, :count).by(-1)
			end

			it "deletes nested validation attributes" do
				expect do
				xhr :delete, :destroy, :order_type_id => @order_type.id, id: @order
				end.to change(Validation, :count).by(-4) 
				#:order_type factory creates 4 tasks, calling DELETE will reduce collection by 4 validations
			end
			
			it "does not destroy tasks" do
				expect do
				xhr :delete, :destroy, :order_type_id => @order_type.id, id: @order
				end.to change(Task, :count).by(0) 
			end
		end
	end

end
