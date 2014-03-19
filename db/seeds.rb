def notice(item)
	puts "-"*60
	puts "Completed: #{item}"
	puts "-"*60
end



#Order Type
@order_type = OrderType.create(title:"fnfi errors")
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
cats = {1 => [1,2,3], 2 => [1,2,3], 3 => [1,2,3]}

test_type = OrderType.create(title: "Test Template")

cats.each_pair do |key, values|
	cat = Category.create(name: "Category #{key}", order_type_id: test_type.id)
	values.each do |t|
		Task.create(description: "Task #{key}-#{t}", category_id: cat.id)
	end
end

notice "Test Database"


def rolling
	rand(20)+1 <= 2 ? true : false
end

def have_error(order)
	@order_type.tasks.each do |task|
		Validation.create(
			approval: rolling,
			order_id: order.id,
			task_id: task.id)
	end
end

#Validations have no errors
def no_error(order)
	@order_type.tasks.each do |task|
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
	num = Proc.new {rand(arr.length)}
	count = rand(10..20)
	note = []
	count.times do
		note << arr[num.call] + " "
	end
	note = note.join.capitalize.gsub(/.$/,"") + "."
end

def create_orders_for(month, type, number)
	puts "Creating orders for #{type.title} in #{Date::MONTHNAMES[month]}...this may take awhile"
	puts "..."
	number.times do
		order = Order.create(
			order_type_id: type.id,
			order: create_order_num,
			created_at: randomize_day(month))

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
	notice("Orders for #{Date::MONTHNAMES[month]}")
end

#Main test database to test load
create_orders_for(1, test_type, 20)
create_orders_for(2, test_type, 40)
create_orders_for(3, test_type, 25)
create_orders_for(2, @order_type, 250)
create_orders_for(3, @order_type, 300)
create_orders_for(4, @order_type, 1000)


