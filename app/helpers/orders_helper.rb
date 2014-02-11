module OrdersHelper
	
	def quality
		clear = @orders.no_errors.count
		total = @orders.count
		pct = (clear/total.to_f*100).round(2)
		
		hash = Hash.new(0)
		hash[:clear] = clear
		hash[:total] = total
		hash[:pct] = pct
		return hash

	end

end
