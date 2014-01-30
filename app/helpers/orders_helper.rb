module OrdersHelper
	# OLD STUFF - instead of iterating over the databse everytime
	#utilize the order.rb order_type.rb methods that create 
	#a separate collection
	def find_order_type
		OrderType.find(params[:order_type_id])
	end

def count_errors(orders)
		sum = 0
		orders.each do |x|
			if x.validations.where(approval:true).count > 0
				sum = sum + 1
			else
				sum
			end
		end
		return sum
	end

	def quality(orders)
		errors = count_errors(orders)
		total = orders.count
		return 100-(errors/total.to_f*100).round(2)
	end
end

def orders_by_day(date)
	@order_type.orders.where(created_at: date..date+1)
end

def errors_by_day(date)
	sum = 0
	orders_by_day(date).each do |x|
		if x.validations.where(approval:true).count > 0
			sum = sum + 1
		else
			sum
		end
	end
	return sum
end
