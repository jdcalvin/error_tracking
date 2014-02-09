class OrderType < ActiveRecord::Base
	before_save {self.title = title.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks
	has_many :orders
	has_many :categories, through: :tasks

	accepts_nested_attributes_for :tasks

	def by_day(date)
		date = date.in_time_zone
		error = has_errors.select { |order| order.created_at >= date && order.created_at < date.end_of_day}.count
		correct = no_errors.select {|order| order.created_at >= date && order.created_at < date.end_of_day}.count
		hash = Hash.new(0)
		hash["Error"] = error
		hash["Correct"] = correct
		hash["Total"] = hash.values.sum
		hash["Pct"] = (correct / (error + correct).to_f*100).round(2)
		return hash 
	end

	def breakdown
		arr = []
		new_hash = Hash.new(0)
		hash = Hash.new{|h, k| h[k] = []}
		orders.each do |order|
			unless order.show_errors.empty?
				order.show_errors.each_pair do |k,v|
					hash[k] << v
				end
			end
		end

		hash.each do |x|
			new_hash[x[0]] = x[1].flatten
		end
		new_hash.each_pair do |key, value|
			res = Hash[value.group_by {|x| x}.map {|k, v| [k,v.count]}]
			new_hash[key] = res
		end

		return new_hash
	end

	def quality
		return 100-(has_errors.count/orders.count.to_f*100).round(2)
	end

	def has_errors
		orders.select {|order| order.show_errors.any? }
	end

	def no_errors
		orders.reject {|order| order.show_errors.any?}
	end

end