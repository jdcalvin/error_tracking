
def notice(item)
	h1("CREATED #{item.class.name}: NAME: #{title_selector(item)} | ID: #{item.id}")
end

def title_selector(item)
	case item.class.name
	when "Order"
		item.order_name
	when "User"
		if item.admin == true
			status = 'Admin'
		else
			status = 'User'
		end
		arr = [item.email, status]
	when 'OrderType'
		item.title
	when 'Organization'
		item.title
	when 'Category'
		item.name
	when 'Task'
		item.description
	when 'Validation'
		puts 'Validation'
	end
		#No ELSE - should already be verified
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

def hashify(opts)
	key = opts.slice(0..(opts.index(':')-1)) 
	value = opts.slice(key.index(key.last)+2..-1).to_i
	hash = Hash.new
	hash[key] = value
	hash
end