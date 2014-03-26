class UsersController < ApplicationController
	def show
		@user = current_user
		@orders = Order.where(user_id: @user.id).reorder('created_at ASC').page(params[:page]).per_page(20)
	end
end
