#Moving seeds over here...sometime

namespace :demo do 
	desc "Adds sample organization to DB- Takes optional 'user:' argument"
	task :org, [:opts] => :environment do |t, args|
		opts = args[:opts]
		make_org(opts)
	end
	
	desc "Adds sample order_type to DB - Takes required organization id as argument"
	task :order_type, [:org, :cat_opts, :task_opts] => :environment do |t, args|
		org = args[:org]
		cat_opts = args[:cat_opts]
		task_opts = args[:task_opts]

		if validate_request(org, Organization)
				make_order_type(org, cat_opts, task_opts)
		else
			return_obj(Organization)
		end
	end

	task :test, [:number, :cat_opts, :task_opts] => :environment do |t, args|
		cat_opts ||= hashify(args[:cat_opts])
		task_opts ||= hashify(args[:task_opts])
		number ||= args[:number]
		puts "Number: " + number
		puts cat_opts["category"]
		puts task_opts["task"]
	end

	task
end