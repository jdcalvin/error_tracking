module UsersHelper
	def user_status?
		if current_user.nil?
			msg = "Sign Up"
		else
			msg =  "Create new User"
		end
		msg
	end
end
