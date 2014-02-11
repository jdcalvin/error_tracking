class Order < ActiveRecord::Base
  belongs_to :order_type
  validates :order_type, presence: true
  has_many :validations, dependent: :destroy
  has_many :tasks, through: :order_type
	has_many :categories, through: :tasks
  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :validations
  
  def show_errors
  	errors = validations.select { |x| x.approval }
  	hash = Hash.new{|h,k| h[k] = []}
	  errors.each {|x| hash[x.category.name] << x.task.description }
  	return hash
  end

  def self.date(date)
 	 Order.where(created_at: date)
	 .includes(:validations)
	 #.includes(:tasks)
	 #.includes(:categories)
  end

	def self.with_errors
		self.select {|order| order.show_errors.any? }
	end

	def self.no_errors
		self.select {|order| order.show_errors.empty? }
	end

end
