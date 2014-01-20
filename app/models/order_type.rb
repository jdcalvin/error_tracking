class OrderType < ActiveRecord::Base
	before_save {self.title = title.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks
end
