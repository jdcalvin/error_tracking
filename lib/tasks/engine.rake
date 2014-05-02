
def notice(item)
	h1("CREATED #{item.class.name}: NAME: #{item.title} | ID: #{item.id}")
end

def notice_collection(item)
	h2("CREATED #{item.count} #{item.klass.name.pluralize}")
end

def h1(*title)
	if title.empty?
		puts "="*80
	else
		puts "="*80
		puts title
		puts "="*80+"\n "
	end	
end

def h2(*title)
	if title.empty?
		puts "-"*80
	else
		puts title
		puts "-"*80+"\n "
	end	
end

def list_orgs
	Organization.all.each do |x|
		puts "ID: #{x.id} - #{x.title}"
	end
end

def validate_request(item, type) #Routes rake options to appropriate respose
	if obj(item,type).nil?
		false
	else
		true
	end
end

def obj(item, type) #Checks to see if object exists and returns true or false
	begin
		type.find(item)
	rescue ActiveRecord::RecordNotFound
	end
end

def return_obj(obj)
	puts ""
	h1("ERROR: INVALID SELECTION", "Please re-run rake task with a valid id from the following selections:")
	h2
	obj.all.each do |x|
		puts x.inspect[2..60]+"..."
	end
	puts ""
	h2("If empty re-run parent task to create a parent object")
end