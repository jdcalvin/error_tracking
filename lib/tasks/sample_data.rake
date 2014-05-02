#Moving seeds over here...sometime

namespace :db do 
	desc "Fill database will sample data"
	#Include options
	task create_org: :environment do |t, args|
		make_org
	end
	
	task :create_order_type, [:org] => :environment do |t, args|
		org = args[:org]
		if validate_request(org, Organization)
			make_order_type(org, Organization)
		else
			return_obj(Organization)
		end
	end
end