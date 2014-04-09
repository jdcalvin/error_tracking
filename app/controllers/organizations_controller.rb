class OrganizationsController < ApplicationController
	before_filter :authenticate_user!
	before_action :validate_admin, except: [:index, :show]
	before_action :no_org?, only: [:new]
	before_action :validate_org, except: [:new, :create]
	
	def index
		redirect_to @organization
	end

	def admin
	end
	
	def edit
	end

	def update
    if @organization.update(organization_params)
      flash[:success] = "Organization was successfully updated"
      redirect_to @organization  
    else
      render action: 'edit'
    end
  end

	def show
		if @organization.nil?
			redirect_to new_organization_path
		end
		@users = @organization.users.reorder('last_name ASC').page(params[:page]).per_page(10)
		@order_types = @organization.order_types
	end

	def new
		@organization = Organization.new
	end

	def create
		@organization = Organization.new(organization_params)
   		if @organization.save
    		current_user.update_attributes(organization_id: @organization.id)
    		flash[:success] = "Organization created"
      	redirect_to @organization
    	else
      render action: 'new'
    end
	end

	def destroy
	end

	private

	def no_org?
		if @organization != nil
			redirect_to root_path
			flash[:warning] = "You already belong to an organization"
		end
	end

	def validate_org
		if signed_in? && @organization.nil?
			redirect_to new_organization_path
			flash[:warning] = "Please create an organization"
		end
	end

	def validate_admin
		unless current_user.admin?
			redirect_to root_path
			flash[:warning] = "You do not have the required permission."
		end
	end

	def organization_params
		params.require(:organization).permit(:title)
	end
end
