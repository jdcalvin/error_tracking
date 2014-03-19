module OrdersHelper

	def quality
		(@order_error_status[false].size/@orders.size.to_f*100).round(2)
	end

  def get_months
  	arr = []
		12.times do |month|
			month = month + 1
			arr << Date::MONTHNAMES[month]
		end
		return arr
	end

	def breakdown(date)
		unless @orders_by_day[date].nil?
			orders = @orders_by_day[date].group_by {|x| x.error}
			orders.each_pair do |k,v| 
				v = v.count
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
		(breakdown(date)[false]/breakdown(date).values.sum.to_f*100).round(2)
	end
end
