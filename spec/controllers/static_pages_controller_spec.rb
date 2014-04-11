require 'spec_helper'

describe StaticPagesController do
	let(:user) {FactoryGirl.create(:admin)}
	before{sign_in user}

	describe "GET #home" do
		it 'if logged in should redirect to organization path' do
			get :home
			expect(response).to redirect_to user.organization
		end

		it 'if logged out renders :home page' do
			sign_out user
			get :home
			expect(response).to render_template :home
		end
	end
	describe "GET #about" do
		it 'should return about path' do
			expect(about_path).to eq '/about'
		end
		it 'renders :about page' do
			get :about
			expect(response).to render_template :about
		end
	end

	describe "GET #contact" do
		it 'should return contact path' do 
			expect(contact_path).to eq '/contact'
		end
		it 'renders :contact page' do
			get :contact
			expect(response).to render_template :contact
		end
	end
	describe "GET #help" do
		it 'should return help path' do 
			expect(help_path).to eq '/help'
		end
		it 'renders :help page' do
			get :help
			expect(response).to render_template :help
		end
	end

end
