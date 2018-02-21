	class UsersController < ApplicationController
	before_filter :authenticate_user!, :except => [:new, :create, :cancel]
	before_filter :validate_admin, :only => [:new, :create, :cancel]
	before_filter :logged_in?, :only => [:new, :create, :cancel]
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :validate_org, :except => [:new, :create, :cancel]

	def index
		if logged_in?
			@users = current_user.organization.users.page(params[:page]).per_page(10)	
			redirect_to @organization
		else
			redirect_to root_path
		end
		
	end

	def show	
		if signed_in?
			@user = User.find(params[:id])
			@orders = Order.where(user_id: @user.id).reorder('created_at DESC').page(params[:page]).per_page(20)
		end
		if @organization == nil
			redirect_to new_organization_path
			flash[:info] = "You must create an organization before continuining."
		end
	end

	def new
		@user = User.new
	end

	def create	
		@user = User.new(user_params)
		if @user.save
			if logged_in?
				@user.update_attributes(admin:false, 
					organization_id: current_user.organization_id)
				redirect_to users_path
				flash[:notice] = "Successfully created User."
			else
				@user.update_attributes(admin: true)
				redirect_to new_user_session_path
				flash[:info] = "Please login with your credentials"
			end

		else
			render :action => 'new'
		end
	end

	def edit
		unless @user == current_user
			validate_admin
		end
	end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      sign_in(@user, :bypass_sign_in => true) if @user == current_user
      redirect_to @user, :flash => { :success => 'User was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

	def destory
		@user.update_attributes(active:false)
	end

	private

	def logged_in?
		if current_user.nil?
			return false
		else
			return true
		end
	end

	def validate_org
		if current_user.organization == nil
			redirect_to new_organization_path
			flash[:warning] = "Please create an organization"
		end
	end


	def validate_admin #Admin can only create users
		if signed_in?
			unless current_user.admin?
				redirect_to @organization
				flash[:warning] = "You do not have the required permission"
			end
		end
	end
	
	def set_user
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :active,
    	:email, :organization_id, :password, :password_confirmation, :admin)
  end

  def require_no_authentication
  	if current_user.admin?
      return true
  	else
      return super
  	end
  end
	
end
