module OrdersHelper

	def find_order_type
		OrderType.find(params[:order_type_id])
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
			return Order.where('created_at >= ? and created_at < ?', num, num+1)
	end

	def quality(num)
		errors = count_errors(num)
		total = orders_by_day(num).count
		return 100-(errors/total.to_f*100).round(2)
	end
end
