module OrdersHelper
	
	def find_order_type
		OrderType.find(params[:order_type_id])
	end

	def quality
		(@no_errors.count / @orders.count.to_f*100).round(2)
	end

end
