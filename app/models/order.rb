class Order < ActiveRecord::Base
  belongs_to :order_type
  validates :order_type, presence: true
  has_many :validations, dependent: :destroy
  has_many :tasks, through: :order_type
  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :validations
  #default_scope -> { order('created_at ASC') }

  def show_errors
  	#FOR TESTING - USE order = Order.find(502)
  	errors = validations.to_a.select { |x| x.approval }
  	hash = Hash.new{|h,k| h[k] = []}
  	errors.each do |x|
  		hash[x.task.category.name] << x.task.description
  	end
  	return hash
  end



end
