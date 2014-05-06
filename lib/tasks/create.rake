
#====================================================================
#ORGANIZATION
def make_org(opts={}) #:user, :order_type
		name = Faker::Company.name
		org = Organization.create!(title: name)
		notice(org)
		opts = hashify(opts)

		create_records(opts)
		if opts.keys == [:user]
			opts["user"].times do 
				make_user(org, false)
			end
		end
		make_user(org, true)
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
def make_task(category)
	desc = "Task #{rand(100..999)}"
	Task.create(description: desc, category: category)
end

#====================================================================
#CATEGORY
def make_category(type)
	name = "Category #{rand(100..999)}"
	Category.create(name: name, order_type: type)
end

#====================================================================
#ORDER_TYPE
def make_order_type(org, cat_opt, task_opt)
	title = Faker::Commerce.department
	cat_opt = hashify(cat_opt)
	task_opt = hashify(task_opt)

	type = OrderType.create(title: title, organization_id: org)
	notice(type)

	categories = []
	cat_opt["category"].times do
		categories << make_category(type)
	end
	notice_collection(type.categories)

	categories.each do |category|
		task_opt["task"].times do
			make_task(category)
		end
	end
	notice_collection(type.tasks)
end

#====================================================================
#ORDER
def make_order
end

#====================================================================
#VALIDATIONS
def make_validation
end