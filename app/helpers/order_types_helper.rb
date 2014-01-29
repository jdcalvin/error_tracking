module OrderTypesHelper

def chart_errors
	hash = @order_type.breakdown
	hash.each_pair do |key, value|
		sum = 0
		value.each_pair do |kk, vv|
			sum = sum + vv
		end
		hash[key] = sum
	end
	return hash
end

end
