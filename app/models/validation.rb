class Validation < ActiveRecord::Base
  belongs_to :task
  belongs_to :order, inverse_of: :validations
  
  validates_uniqueness_of :order_id, :scope => :task_id
  validates_uniqueness_of :task_id, :scope => :order_id

  validates :approval, inclusion: [true, false]
  validates :order, presence: true
  validates :task_id, presence: true

	delegate :category, :to => :task

	def task_description
		task.description
	end

	def category_name
			category.name
	end

end
