module OrdersHelper
	
	def find_order_type
		OrderType.find(params[:order_type_id])
	end

	def quality
		(@no_errors.count / @orders.count.to_f*100).round(2)
	end

	def breakdown
	end

	def errors_by_date(date)
		date = date.in_time_zone
		@with_errors.select {|order| order.created_at >= date && order.created_at < date.end_of_day}.count
	end

	def clear_by_date(date)
		date = date.in_time_zone
		@no_errors.select { |order| order.created_at >= date && order.created_at < date.end_of_day}.count
	end

	def order_by_date(date)
		date = date.in_time_zone
		Order.date(date..date.end_of_day).count
	end
	
end
