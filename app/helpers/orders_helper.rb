module OrdersHelper
	
	def find_order_type
		OrderType.find(params[:order_type_id])
	end
end
