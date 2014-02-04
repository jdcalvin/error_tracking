puts "Setting up sample database..."

#Order Type
order_type = OrderType.create(title:"fnfi errors")
puts "Setting up template #{order_type.title}:"

#Categories
cat = ["city lien", "datedown", "documents", "general", "names", "policy", "taxes"]
cat.each do |x|
Category.create(name: x)
end

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

puts "Creating tasks"
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
puts "#{order_type.title} completed"

#Randomizes order number
def create_order_num
	arr = "TST00".split(//)
	5.times do 
		arr << rand(10)
	end
	arr.join
end

def rolling
	rand(20)+1 <= 2 ? true : false
end

def have_error(order)
	order.tasks.each do |task|
		Validation.create(
			approval: rolling,
			order_id: order.id,
			task_id: task.id)
	end
end

#Validations have no errors
def no_error(order)
	order.tasks.each do |task|
		Validation.create(
			approval: false,
			order_id: order.id,
			task_id: task.id)
	end
end

#Generates random date for given month, excluding weekends
def randomize_day(month)
	t = Date.parse("1.#{month}.2014")
	days = (t..t.end_of_month).count
	date = Date.new(2014, month, rand(days)+1)
	if date.saturday? || date.sunday?
		randomize_day(month)
	else
		return date
	end
end

puts "Creating 500 orders for January...this may take awhile"
500.times do
	order = Order.create(
		order_type_id: 1,
		order: create_order_num,
		created_at: randomize_day(1))

	#30% chance an error will occur
	if rand(100)+1 > 70 
		have_error(order)
	else
		no_error(order)
	end
end

puts "Creating 500 orders for February...this may take awhile"
500.times do
	order = Order.create(
		order_type_id: 1,
		order: create_order_num,
		created_at: randomize_day(2))

	#30% chance an error will occur
	if rand(100)+1 > 70 
		have_error(order)
	else
		no_error(order)
	end
end	