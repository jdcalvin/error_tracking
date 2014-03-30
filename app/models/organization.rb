class Organization < ActiveRecord::Base
	has_many :order_types
	has_many :users
	has_many :orders, :through => :order_types
	validates :title, :presence => true
	before_save {self.title = title.split.map {|x| x.capitalize }.join(" ") }
end
