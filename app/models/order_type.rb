class OrderType < ActiveRecord::Base
	before_save {self.title = title.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks
	has_many :orders
	has_many :categories, through: :tasks

	accepts_nested_attributes_for :tasks

	def count_total_errors
		sum = 0
		orders.each do |order|
			if order.validations.select {|x| x.approval?}.count > 0
				sum = sum + 1
			end
		end
		return sum
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
		counter = 0

		hash.each do |x|
			new_hash[x[0]] = x[1].flatten
		end
		new_hash.each_pair do |key, value|
			res = Hash[value.group_by {|x| x}.map {|k, v| [k,v.count]}]
			new_hash[key] = res
		end

		return new_hash
	end
end

# data set is saved in app folder - need to apply this to each key value
# so each key value would be 'arr'
# arr would be re-inserted in the hash as:
# {key =>{key=> value}
#res = Hash[arr, group_by {|x| x}.map {|k, v| [k,v.count]}]