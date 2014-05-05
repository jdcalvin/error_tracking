#Moving seeds over here...sometime

namespace :demo do 
	desc "Adds sample organization to DB- Takes optional 'user:' argument"
	#Include options
	task :org, [:opts] => :environment do |t, args|
		opts = args[:opts]
		make_org(opts)

	end
	desc "Adds samle order_type to DB - Takes required organization id as argument"
	task :order_type, [:org] => :environment do |t, args|
		org = args[:org]
		if validate_request(org, Organization)
			make_order_type(org, Organization)
		else
			return_obj(Organization)
		end
	end
end