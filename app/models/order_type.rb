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
			else
				sum
			end
			sum
		end
		return sum
	end


	#def placeholder
	#	errors = []
  #	hash = Hash.new{|h,k| h[k] = []}
	#	orders.each do |order|
	#		errors = errors.flatten << order.validations.select{ |x| x.approval?}.flatten
	#	end
	#	errors = errors.flatten
	#	errors.each do |x|
	#		hash[x.task.category.name] << x.task.description
		#end

	#	return errors
	#end

	def placeholder
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
			# x[1,1].flatten

		return new_hash
	end
end

#def placeholder2
#all errors are in placeholder
#	placeholder 
#end
