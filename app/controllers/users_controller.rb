class UsersController < ApplicationController
	def show
		@user = current_user
		@orders = Order.where(user_id: @user.id).page(params[:page]).per_page(20)
	end
end
