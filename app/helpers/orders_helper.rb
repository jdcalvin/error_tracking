module OrdersHelper

	def find_order_type
		OrderType.find(params[:order_type_id])
	end

	def fake_time(num)
		Time.mktime(2014, 01, num)
	end

	def sort_by_day #RETURNS ARRAY OF ALL DAYS WHERE A RECORD IS PRESENT
		days = []
		@order_type.orders.each do |x|
			days << x.created_at.day
		end
		
		return days.uniq.sort
	end

	def count_errors(num)
		sum = 0
		orders_by_day(num).each do |x|
			if x.validations.where(approval:true).count > 0
				sum = sum + 1
			else
				sum
			end
		end
		return sum
	end

	#USAGE
	# find_order_type.title = Title 
	# find_order_type.id = ID

	def orders_by_day(num)
		if num.to_s.length == 1
			return Order.where('created_at >= ? and created_at < ?', "2014-01-0#{num}", "2014-01-0#{num+1}")
		else
			return Order.where('created_at >= ? and created_at < ?', "2014-01-#{num}", "2014-01-#{num+1}")
		end
	end
	
end