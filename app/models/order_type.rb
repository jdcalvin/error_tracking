class OrderType < ActiveRecord::Base
	before_save {self.title = title.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks
	has_many :orders
	has_many :categories, through: :tasks
	accepts_nested_attributes_for :categories, allow_destroy: true,
		reject_if: lambda {|x| x[:name].blank? }
	accepts_nested_attributes_for :tasks, allow_destroy: true,
		reject_if: lambda {|x| x[:description].blank? }
end
