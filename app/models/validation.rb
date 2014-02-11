class Validation < ActiveRecord::Base
  belongs_to :task
  belongs_to :order
	delegate :category, :to => :task
  validates :approval, inclusion: [true, false]


	def task_description
		read_attribute("task_description") || task.description
	end

	def category_name
		read_attribute("category_name") || category.name
	end

end
