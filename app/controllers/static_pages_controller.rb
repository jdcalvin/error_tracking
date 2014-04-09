class StaticPagesController < ApplicationController

def home
	if signed_in?
		if @organization.nil?
			redirect_to new_organization_path
		else
			redirect_to @organization
		end
	end
end

def help
end

def contact
end

end
