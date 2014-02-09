class Order < ActiveRecord::Base
  belongs_to :order_type
  validates :order_type, presence: true
  has_many :validations, dependent: :destroy
  has_many :tasks, through: :order_type
  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :validations
  
  def show_errors
  	errors = validations.select { |x| x.approval }
  	hash = Hash.new{|h,k| h[k] = []}
	errors.each {|x| hash[x.task.category.name] << x.task.description }
  	return hash
  end

end
