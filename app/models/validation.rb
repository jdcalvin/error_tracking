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

	def self.show_errors
		errors = self.select {|x| x.approval }
  	hash = Hash.new{|h,k| h[k] = []}
	  errors.each {|x| hash[x.category_name] << x.task_description }
  	return hash
  end


end
