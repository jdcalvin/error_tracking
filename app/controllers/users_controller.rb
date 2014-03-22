class UsersController < ApplicationController
	def show
		@user = current_user
		@orders = Order.where(user_id: @user.id)
	end
end
