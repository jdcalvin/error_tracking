class Admin::UsersController < ApplicationController
	prepend_before_filter :require_no_authentication, :only =>[:new, :create, :cancel]
	def new
		@user = User.new
	end

	def create
		
		@user = User.new(params[user_params])
		@user.admin = false

		if @user.save
			flash[:notice] = "Successfully created User."
		else
			render :action => 'new'
			flash[:info] = "fuck you"
		end

	end
	private
	
	def set_user
      @user = User.find(params[:id])
  end

    def user_params
      params.require(:user).permit(:first_name, :last_name, 
      	:email, :organization_id, :password, :password_confirmation, :admin)
    end

end
