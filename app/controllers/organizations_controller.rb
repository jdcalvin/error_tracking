class OrganizationsController < ApplicationController
	before_filter :authenticate_user!
	#before_action :set_organization, only: [:show, :edit, :update, :destroy]
	before_action :validate_admin, only: [:edit, :update, :new, :create, :destroy, :admin]
	before_action :no_org?, only: [:new]
	
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
		if current_user.organization != nil
			redirect_to root_path
			flash[:warning] = "You already belong to an organization"
		end
	end

	def validate_admin
		unless current_user.admin?
			redirect_to root_path
			flash[:warning] = "You do not have the required permission."
		end
	end

	def set_organization
		@organization = Organization.find(params[:id])
	end

	def organization_params
		params.require(:organization).permit(:title)
	end

end
