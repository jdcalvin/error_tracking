class Validation < ActiveRecord::Base
  belongs_to :task
  belongs_to :order
	delegate :category, :to => :task
  validates :approval, inclusion: [true, false]


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

end
