class Validation < ActiveRecord::Base
  belongs_to :task
  belongs_to :order, inverse_of: :validations
	delegate :category, :to => :task
  validates :approval, inclusion: [true, false]
  validates_uniqueness_of :order_id, :scope => :task_id
  validates_uniqueness_of :task_id, :scope => :order_id
  validates :order, presence: true
  validates :task_id, presence: true

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
