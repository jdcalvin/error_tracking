require 'spec_helper'

describe OrganizationsController do
	describe 'GET #index' do
		it 'returns users organization path'
		it 'redirects if organization does not exist'
	end
	describe 'GET #show' do
		it 'returns current users organization path'
		it 'renders the :show template'
	end
	describe 'GET #new' do
		it 'renders the :new template'
		it 'redirects if permissions are invalid'
	end
	describe 'POST #create' do
		context 'IF valid' do
			it 'saves organization'
			it 'redirects to organization'
		end
		context 'IF invalid' do
			it 'does not save organization'
			it 'shows errors'
			it 're-renders :edit template'
		end
	end
	describe 'GET #edit' do
		it 'renders the :edit template'
		it 'redirects if permissions are invalid'
	end
	describe 'PUT #update' do
		it 'saves organization'
	end
	describe 'DELETE #destroy' do
		pending("Unsure of applications implementation, if any")
	end

	describe 'GET #admin' do
		it 'renders the :admin template'
		it 'restricts user access'
		it 'allows admin access'
	end

end
