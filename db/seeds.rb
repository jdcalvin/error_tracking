puts "Creating sample database - this may take awhile..."
#Categories
cat = ["city lien", "datedown", "documents", "general", "names", "policy", "taxes"]
cat.each do |x|
Category.new(name: x).save
end

#Order Type
order_type = OrderType.new(title:"fnfi errors").save



#Tasks
city_lien = ["did not update", "incorrect amount"]
datedown = ["did not run", "doc is incorrect", "wrong effective date",
						"missed exceptions", "did not update new vesting"]
documents = ["did not upload new docs", "labeled incorrectly", 
							"wrong docs uploaded"]
general = ["exceptions wrong", "wrong supp version"]

names = ["did not update name", "listing old buyers", "name incorrect", 
					"new buyers not added"]
policy = ["did not update amount", "incorrect FNF sheet", "missed new loan",
					"missed proposed insured", "wrong types/short term"]
taxes = ["did not update", "shown incorrectly", "wrong data"]

def convert_to_id(cat_name)
	cat_name = Category.find_by(name: cat_name)
	return cat_name.id.to_i
end


city_lien.each do |x|
	Task.new(description: x, category_id: convert_to_id("City Lien")).save
end

datedown.each do |x|
	Task.new(description: x, category_id: convert_to_id("Datedown")).save
end

general.each do |x|
	Task.new(description: x, category_id: convert_to_id("General")).save
end

names.each do |x|
	Task.new(description: x, category_id: convert_to_id("Names")).save
end

policy.each do |x|
	Task.new(description: x, category_id: convert_to_id("Policy")).save
end

taxes.each do |x|
	Task.new(description: x, category_id: convert_to_id("Taxes")).save
end


#Randomizes order number
def create_order_num
	arr = "TST00".split(//)
	5.times do 
		arr << rand(10)
	end
	arr.join
end

#Validations have an average return of 1-3 errors 
def have_error(order)
	order.tasks.each do |task|
		v = Validation.new
		if rand(20)+1 <= 2 
			v.approval = true
		else
			v.approval = false
		end
		v.order_id = order.id
		v.task_id = task.id
		v.save
	end
end

#Validations have no errors
def no_error(order)
	order.tasks.each do |task|
		v = Validation.new
		v.approval = false
		v.order_id = order.id
		v.task_id = task.id
		v.save
	end
end

#Creates 500 orders
500.times do
	order = Order.new(order_type_id: 1)
	order.order = create_order_num

	#Randomizes day the order was created
	order.created_at = "2014-01-#{rand(31)+1} 00:00:00"
	order.save

	if rand(100)+1 > 70 #Creating 30% chance an error will occur
		have_error(order)
	else
		no_error(order)
	end
end