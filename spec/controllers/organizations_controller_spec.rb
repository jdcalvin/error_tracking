require 'spec_helper'

describe OrganizationsController do
	let(:user) {FactoryBot.create(:admin)}
	before{sign_in user}

	describe 'GET #index' do
		before :each do
			@organization = FactoryBot.create(:organization)
		end

		it 'returns users organization path' do
			get :index
			expect(response).to redirect_to organization_path(user.organization)
		end		
	end

	describe 'GET #show' do
		it 'returns current users organization path' do
			get :show, id: user.organization
			expect(assigns(:organization)).to eq user.organization
		end

		it 'renders the :show template' do
			organization = FactoryBot.create(:organization)

			get :show, id: organization
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		it 'renders the :new template' do
			user.update_attributes(organization: nil)
			get :new
			expect(response).to render_template :new
		end

		it 'redirects if permissions are invalid' do
			user.update_attributes(admin:false)
			get :new
			expect(response).to redirect_to root_path
		end
	end

	describe 'POST #create' do
		context 'IF valid' do
			it 'saves organization' do
				expect do
					user.update_attributes(organization:nil)
					xhr :post, :create, organization: attributes_for(:organization)
				end.to change(Organization, :count).by(1)
			end

			it 'redirects to organization' do
				user.update_attributes(organization:nil)
				xhr :post, :create, organization: attributes_for(:organization)
				expect(response).to redirect_to organization_path(assigns[:organization])
			end
		end

		context 'IF invalid' do
			it 'does not save organization' do
				expect do
					user.update_attributes(organization:nil)
					xhr :post, :create, organization: attributes_for(:invalid_organization)
				end.to change(Organization, :count).by(0)
			end

			it 'shows errors' do
				user.update_attributes(organization:nil)
				@org = FactoryBot.build(:invalid_organization)
				@org.valid?
				expect(@org.errors.messages[:title]).to include("can't be blank")
			end

			it 're-renders :new template' do
				user.update_attributes(organization:nil)
				xhr :post, :create, organization: attributes_for(:invalid_organization)
				expect(response).to render_template :new
			end
		end
	end

	describe 'GET #edit' do
		it 'renders the :edit template' do
			xhr :get, :edit, id: user.organization
			expect(assigns[:organization]).to eq user.organization
		end

		it 'redirects if permissions are invalid' do
			user.update_attributes(admin:false)
			xhr :get, :edit, id: user.organization
			expect(response).to redirect_to root_path
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			it 'locates the requested resource' do
				patch :update, id: user.organization, organization: attributes_for(:organization, title: "Changing")
				expect(assigns(:organization)).to eq(user.organization)
			end

			it 'redirects to organization' do
				patch :update, id: user.organization, organization: attributes_for(:organization, title: "Blah")
				expect(response).to redirect_to organization_path(user.organization)
			end
		end

		context 'with invalid attributes' do
			it 'does not save organization' do
				patch :update, id: user.organization, organization: attributes_for(:organization, title: nil)
				user.organization.reload
				expect(user.organization).to_not eq nil
			end

			it 'shows errors' do
				user.organization.update_attributes(title:nil)
				user.organization.valid?
				expect(user.organization.errors.messages[:title]).to include("can't be blank")
			end

			it 're-renders :edit template' do
				patch :update, id: user.organization, organization: attributes_for(:organization, title: nil)
				expect(response).to render_template :edit
			end
		end
	end
	
	describe 'DELETE #destroy' do
		#No application implementation
	end

	describe 'GET #admin' do
		it 'renders the :admin template' do
			get :admin, {:organization_id => user.organization.id}
			expect(response).to render_template :admin
		end

		it 'restricts user access' do
			user.update_attributes(admin:false)
			get :admin, {:organization_id => user.organization.id}
			expect(response).to redirect_to root_path
		end
	end

end
