class Validation < ActiveRecord::Base
  belongs_to :task
  belongs_to :order, inverse_of: :validations
	delegate :category, :to => :task
  validates :approval, inclusion: [true, false]
  validates_uniqueness_of :order_id, :scope => :task_id
  validates_uniqueness_of :task_id, :scope => :order_id
  validates :order, presence: true
  validates :task_id, presence: true
  #after_save :update_order

  def update_order
    if self.approval
      unless self.order.error = true
        self.order.update_attributes(error:true)
      end
    else false
      return
    end
  end

	def task_description
		Rails.cache.fetch([:task, task_id, :description], expires_in: 5.minutes) do
		task.description
		end
	end

	def category_name
		Rails.cache.fetch([:category, category.id, :name], expires_in: 5.minutes) do
			category.name
		end
	end

	def self.show_errors
		errors = self.select {|x| x.approval }
  	hash = Hash.new{|h,k| h[k] = []}
	  errors.each {|x| hash[x.category_name] << x.task_description }
  	return hash
  end

end
