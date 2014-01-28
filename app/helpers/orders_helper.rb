module OrdersHelper

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

	#USAGE
	# find_order_type.title = Title 
	# find_order_type.id = ID

	def quality(orders)
		errors = count_errors(orders)
		total = orders.count
		return 100-(errors/total.to_f*100).round(2)
	end
end
