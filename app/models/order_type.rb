class OrderType < ActiveRecord::Base
	before_save {self.title = title.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks, through: :categories
	has_many :orders, dependent: :destroy, inverse_of: :order_type
	has_many :categories, dependent: :destroy, inverse_of: :order_type
	has_many :users, through: :orders
	has_many :validations, through: :orders
	belongs_to :organization
	validates :title, presence: true
	validates :organization_id, presence: true

	accepts_nested_attributes_for :categories, allow_destroy: true,
		reject_if: lambda {|x| x[:name].blank? }
	accepts_nested_attributes_for :tasks, allow_destroy: true
	
	scope :load_associations, lambda {|x| where(id: x).includes(:tasks).includes(:categories).first}

	def breakdown
		before_hash = Hash.new
		categories.each do |cat|		
			hash = Hash.new{|h, k| h[k] = []}
			cat.tasks.each do |task|
				hash[task.description] = 0
				before_hash[cat.name] = hash
			end
		end
		before_hash
	end

end
