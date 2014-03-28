class UsersController < ApplicationController

	def index
		@users = current_user.organization.users.page(params[:page]).per_page(10)
	end

	def show
		@user = current_user
		@orders = Order.where(user_id: @user.id).reorder('created_at DESC').page(params[:page]).per_page(20)
	end
end
