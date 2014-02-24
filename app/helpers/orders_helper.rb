module OrdersHelper

	def orders_by_date(date)
		date = date.in_time_zone
		@orders.select {|x| x.created_at >= date.beginning_of_day && x.created_at <=  date.end_of_day }
	end
	
	def correct_by_date(date)
		date = date.in_time_zone
		@correct.select {|x| x.created_at >= date.beginning_of_day && x.created_at <= date.end_of_day }
	end

	def quality_by_date(date)
		num = correct_by_date(date).size/orders_by_date(date).size.to_f*100
		num.round(2)
	end

	def quality
		(@correct.size/@orders.size.to_f*100).round(2)
	end
end
