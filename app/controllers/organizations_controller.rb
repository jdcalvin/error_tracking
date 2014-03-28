class OrganizationsController < ApplicationController
	before_action :set_organization, only: [:show, :edit, :update, :destroy]
	def index

	end

	def edit
	end

	def show
		@users = @organization.users.reorder('last_name ASC').page(params[:page]).per_page(10)
		@order_types = @organization.order_types
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
