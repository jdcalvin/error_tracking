def notice(item)
	puts"-"*80
	puts "CREATED #{item.class.name}: NAME: #{item.title} | ID: #{item.id}"
	puts "-"*80
end

def notice_collection(item)
	puts "CREATED #{item.count} #{item.klass.name.pluralize}"
end

def list_orgs
	Organization.all.each do |x|
		puts "ID: #{x.id} - #{x.title}"
	end
end

def validate_request(item, type)
	if obj(item,type).nil?
		false
	else
		true
	end
end

def obj(item, type)
	begin
		type.find(item)
	rescue ActiveRecord::RecordNotFound
	end
end

def return_obj(obj)
	puts "="*80
	puts "ERROR: INVALID SELECTION"
	puts "="*80
	puts ""
	puts "Please re-run rake task with a valid id from the following selections:"
	puts "-"*80
	obj.all.each do |x|
		puts x.inspect[2..60]+"..."
	end
	puts"-"*80
	puts " "
	puts "If empty re-run parent task to create a parent object"
end