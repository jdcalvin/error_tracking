require 'spec_helper'

describe UsersController do
	let(:user) {FactoryGirl.create(:user)}
	let(:admin) {FactoryGirl.create(:admin)}
	let(:inactive) {FactoryGirl.create(:inactive)}

	describe 'GET #index' do
		before{sign_in user}
		it 'redirects to users organization path' do
			get :index
			expect(response).to redirect_to organization_path(user.organization)
		end
	end
	describe 'GET #show' do
		before{sign_in user}
		it 'renders the :show template' do
			get :show, id: user
			expect(response).to render_template :show
		end
		it 'assigns params to @user' do
			get :show, id: user
			expect(assigns(:user)).to eq user
		end
	end
	describe 'GET #new' do
		context 'when logged out' do
			it 'renders the :new template' do
				get :new
				expect(response).to render_template :new
			end
		end
		context 'when normal user' do
			before{sign_in user}
			it 'redirects to organization_path' do
				get :new
				expect(response).to redirect_to organization_path(user.organization)
			end
		end
		context 'when admin user' do
			before{sign_in admin}
			it 'renders the :new template' do
				get :new
				expect(response).to render_template :new
			end
		end
	end
	describe 'POST #create' do
		context 'IF valid' do
			it 'saves user' do
				expect do
					xhr :post, :create, user: attributes_for(:user)
				end.to change(User, :count).by(1)
			end
		end
		context 'IF invalid' do
			it 'does not save user' do
				expect do
					xhr :post, :create, user: attributes_for(:user, :email => nil)
				end.to change(User, :count).by(0)
			end
			it 'shows errors' do
				@user = FactoryGirl.build(:user, :email => nil)
				@user.valid?
				@user.errors.messages[:email].should include("can't be blank")
			end
			it 're-renders :new template' do
				xhr :post, :create, user: attributes_for(:user, :email => nil)
				expect(response).to render_template :new
			end
		end
	end
	describe 'GET #edit' do
		context "when regular user" do
			before{sign_in user}
			context "tries editing other user" do
				it 'redirects to organization' do
					other = FactoryGirl.create(:user, :organization => user.organization)
					get :edit, id: other
					expect(response).to redirect_to organization_path(user.organization)
				end
			end
			context 'tries editing self' do
				it 'renders the :edit template' do
					get :edit, id: user
					expect(response).to render_template :edit
				end
			end
		end
		context "when admin user" do
			before{sign_in admin}
			it "renders template if editing other user" do
				other = FactoryGirl.create(:user, :organization => admin.organization)
				get :edit, id: other
				expect(response).to render_template :edit
			end
			it "renders template if editing self" do
				get :edit, id: admin
				expect(response).to render_template :edit
			end
		end

	end
	describe 'PUT #update' do
		before{sign_in user}
		context 'with valid attributes' do
			it 'locates the requested resource' do
				patch :update, id: user, user: attributes_for(:user)
				expect(assigns(:user)).to eq(user)
			end
			it 'saves user' do
				patch :update, id: user, user: attributes_for(:user, :first_name => "Changing")
				user.reload
				expect(user.first_name).to eq "Changing"
			end
		end
		context 'with invalid attributes' do
			it 'does not save user' do
				patch :update, id: user, user: attributes_for(:user, :first_name => nil)
				user.reload
				expect(user.first_name).to_not eq nil
			end
			it 'shows errors' do
				user.update_attributes(email:nil)
				user.valid?
				user.errors.messages[:email].should include("can't be blank")
			end
			it 're-renders the :edit template' do
				patch :update, id: user, user: attributes_for(:user, :first_name => nil)
				expect(response).to render_template :edit
			end
		end
	end
	describe 'DELETE #destroy' do
		#Users should not be deleted, but deactivated
	end

end
