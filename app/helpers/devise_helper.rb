module DeviseHelper
	def devise_error_messages!
		#resource.errors.full_messages.map {|m| content_tag(:li, m) }.join
	end

	def require_no_authentication
		if current_user.admin?
			puts "blahblahblah"
		end
	end

end
			
