#Moving seeds over here...sometime

namespace :db do 
	desc "Fill database will sample data"
	#Include options
	task create_org: :environment do |t, args|
		make_org
	end
	
end