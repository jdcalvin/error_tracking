class OrganizationsController < ApplicationController
	def index
		@organizations = Organization.all
	end

	def edit
	end

	def show
	end

	def new
	end

	def create
	end

	def destroy
	end

	private

	def set_organization
		@organization = Organization.find(params[:id])
	end

	def organization_params
		params.require(:organization).permit(:title)
	end

end
