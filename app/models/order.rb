class Order < ActiveRecord::Base
  belongs_to :order_type
  validates :order_type, presence: true
  validates :order, presence: true
  has_many :validations, dependent: :destroy
  has_many :tasks, through: :validations
	has_many :categories, through: :tasks
  accepts_nested_attributes_for :validations

	def show_errors
  	errors = validations.select {|x| x.approval}
  	hash = Hash.new{|h,k| h[k] = []}
	  errors.each {|x| hash[x.category_name] << x.task_description }
  	return hash
  end

	def self.date(date)
 	 Order.where(created_at: date)
	 .includes(:validations)
	 .includes(:tasks)
	 .includes(:categories)
  end

	def self.with_errors
		self.select {|order| order.show_errors.any? }
	end

	def self.no_errors
		self.select {|order| order.show_errors.empty? }
	end

  def self.breakdown
    new_hash = Hash.new(0)
    hash = Hash.new{|h, k| h[k] = []}
		self.with_errors.each do |order|
      order.show_errors.each_pair do |k,v|
        hash[k] << v
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
	
	def self.search(search)
		if search
			Order.find(:all, :conditions => ['orders.order ILIKE?', "%#{search}%"])
		else
			@orders
		end
	end
end
