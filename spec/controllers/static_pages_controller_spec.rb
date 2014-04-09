require 'spec_helper'

describe StaticPagesController do
	describe "GET #home" do
		it 'if logged in should redirect to organization path'
		it 'if logged out should return root path' do
			expect(root_path).to eq '/'
		end
		it 'renders :home page'
	end
	describe "GET #about" do
		it 'should return about path' do
			expect(about_path).to eq '/about'
		end
		it 'renders :about page'
	end

	describe "GET #contact" do
		it 'should return contact path' do 
			expect(contact_path).to eq '/contact'
		end
		it 'renders :contact page'
	end
	describe "GET #help" do
		it 'should return help path' do 
			expect(help_path).to eq '/help'
		end
		it 'renders :help page'
	end

end
