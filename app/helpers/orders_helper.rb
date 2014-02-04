module OrdersHelper
	
	def find_order_type
		OrderType.find(params[:order_type_id])
	end

	def pst(date)
		date.in_time_zone
	end
end
