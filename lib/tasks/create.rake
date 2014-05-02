#====================================================================
#ORGANIZATION
def make_org
		name = Faker::Company.name
		org = Organization.create!(title: name)
		notice(org)
end

#====================================================================
#USER
def make_user
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
def make_order_type
end

#====================================================================
#ORDER
def make_order
end

#====================================================================
#VALIDATIONS
def make_validation
end