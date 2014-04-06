def notice(item)
	puts "-"*80
	puts "Completed: #{item}"
	puts "-"*80
end

#Organizations

['Title Company', 'Org1', 'Org2'].each do |org|
	Organization.create(title:org)
end
notice "Organizations"
#Users
@orgs = Organization.all

first_names = 
	"John Steve Barry Eugene Darlene Anita Carola Jason Paula Dean Steven Arnie".split
last_names = 
	"Bogart Sleazy Brown Tango Sketty Wylie Sloane Mone Games Nudey Steed Irvine Zero".split

def randomize_admin
	num = rand(100)+1
	if num > 80
		return true
	else
		return false
	end
end

40.times do |x|
	User.create(
		first_name: first_names[rand(first_names.count)], 
		last_name: last_names[rand(last_names.count)], 
		password: "password", 
		email: "test.user#{x}@test.com",
		organization_id: rand(1..3),
		admin: randomize_admin)	
	x = x + 1
end

notice "Users"
@users = User.all

#Order Type
@order_type = OrderType.create(title:"Title Errors", organization_id: 1)
notice @order_type.title

#Categories and Tasks
collection = {
	"city lien" => ["did not update", "incorrect amount"],
	"datedown" => ["did not run", "doc is incorrect", "wrong effective date", "missed exceptions", "did not update new vesting"],
	"documents" => ["did not upload new docs", "labeled incorrectly", "wrong docs uploaded"],
	"general" => ["exceptions wrong", "wrong supp version"],
	"names" => ["did not update name", "listing old buyers", "name incorrect", "new buyers not added"],
	"policy" => ["did not update amount", "incorrect FNF sheet", "missed new loan", "missed proposed insured", "wrong types/short term"],
	"taxes" => ["did not update", "shown incorrectly", "wrong data"]}

collection.each_pair do |key, values|
	cat = Category.create(name: key, order_type_id: @order_type.id)
	values.each do |t|
		Task.create(description: t, category_id: cat.id)
	end
end

notice "Tasks and Categories for #{@order_type.title}"
#Randomizes order number
def create_order_num
	arr = "TST00".split(//)
	5.times do 
		arr << rand(10)
	end
	arr.join
end


#Test database for testing add/remove actions

def test_type_for(org_num)
	test_type = OrderType.create(title: "Template-#{org_num}-#{rand(1000)+1}", organization_id: org_num)
	cats = {1 => [1,2,3], 2 => [1,2,3], 3 => [1,2,3]}
	cats.each_pair do |key, values|
		cat = Category.create(name: "Category #{org_num}-#{key}", order_type_id: test_type.id)
		values.each do |t|
			Task.create(description: "Task #{org_num}-#{key}-#{t}", category_id: cat.id)
		end
	end
end

test_type_for(1)
test_type_for(1)
test_type_for(2)
test_type_for(2)
test_type_for(3)
test_type_for(3)

notice "Test Templates completed"


def rolling
	rand(20)+1 <= 2 ? true : false
end

def have_error(order)
	order.order_type.tasks.each do |task|
		Validation.create(
			approval: rolling,
			order_id: order.id,
			task_id: task.id)
	end
end

#Validations have no errors
def no_error(order)
	order.order_type.tasks.each do |task|
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

def randomize_note
	arr = "among going manor who did do ye is celebrated it sympathize considered may ecstatic did surprise elegance the ignorant age own her miss cold last it so numerous if he outlived disposal how but sons mrs lady when her especially are unpleasant out alteration continuing unreserved resolution hence hopes noisy may china fully and am it regard stairs branch thirty length afford".split(" ")
	note = []
	(rand(10..20)).times do
		note << arr[rand(arr.length)] + " "
	end
	note = note.join.capitalize.gsub(/.$/,"") + "."
end

def create_orders_for(month, type, number)
	org = type.organization
	org_users = []
	org.users.each do |x|
		org_users << x.id
	end

	puts "Creating #{number} orders for #{type.title} in #{Date::MONTHNAMES[month]}"
	puts "..."

	number.times do
		order = Order.create(
			order_type_id: type.id,
			order_name: create_order_num,
			created_at: randomize_day(month),
			user_id: org_users[rand(org_users.length)]
		)

		#30% chance an error will occur
		if rand(100)+1 > 70 
			have_error(order)
		else
			no_error(order)
		end

		if order.errors?
			order.update_attributes(error: true, note: randomize_note)
		else
			order.update_attributes(error:false)
		end
	end
	notice("#{number} orders")
end

#Main test database to test load

OrderType.all.each do |x|
	unless x.id == 2
		create_orders_for(1, x, rand(20..30))
		create_orders_for(2, x, rand(20..30))
		create_orders_for(3, x, rand(20..30))
	end
end

