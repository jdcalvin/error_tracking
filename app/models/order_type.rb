class OrderType < ActiveRecord::Base
	before_save {self.title = title.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks
	has_many :orders
	has_many :categories, through: :tasks
	accepts_nested_attributes_for :tasks
	accepts_nested_attributes_for :categories

end
