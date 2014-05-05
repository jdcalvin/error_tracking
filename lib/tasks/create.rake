
#====================================================================
#ORGANIZATION
def make_org(opts={}) #:user, :order_type
		name = Faker::Company.name
		org = Organization.create!(title: name)
		notice(org)
		key = opts.slice(0..(opts.index(':')-1)) 
		value = opts.slice(key.index(key.last)+2..-1).to_i
		hash = Hash.new
		hash[key] = value
		hash[key].times do
			make_user(org, false) #Regular User
		end
		make_user(org, true) #Admin User
		h2("User passwords are 'password'")
end

#====================================================================
#USER
def make_user(org, type)
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	email = Faker::Internet.safe_email(first_name)
	user = User.create(first_name: first_name, last_name: last_name, 
	email: email, password: 'password', organization_id: org.id, admin: type)
	notice(user)
end
#====================================================================
#TASK
def make_task
end
#====================================================================
#CATEGORY
def make_category
end

#====================================================================
#ORDER_TYPE
def make_order_type(item, type)
	puts item
	puts type
end

#====================================================================
#ORDER
def make_order
end

#====================================================================
#VALIDATIONS
def make_validation
end