module OrdersHelper

	def quality
		if @order_error_status[false].nil?
			return 0.00
		else
		(@order_error_status[false].size/@orders.size.to_f*100).round(2)
	end
	end

	def breakdown(date)
		unless @orders_by_day[date].nil?
			orders = @orders_by_day[date].group_by {|x| x.error}
			orders.each_pair do |k,v| 
				if v.nil?
					v = 0
				else
					v = v.count
				end
				orders[k] = v
			end
		else
			orders = Hash.new
			orders[true] = 0
			orders[false] = 0
		end
		return orders
	end

	def quality_by(date)
		if breakdown(date)[false].nil?
			return 0.00
		else
		(breakdown(date)[false]/breakdown(date).values.sum.to_f*100).round(2)
		end
	end

	def show_orders_by_month
		time_now = @today
		time_last_month = @today - 1.month
		time_last_2_month = @today - 2.month
		[time_now, time_last_month, time_last_2_month]
	end

end
