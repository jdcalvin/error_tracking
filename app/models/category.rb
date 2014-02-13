class Category < ActiveRecord::Base
	before_save {self.name = name.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks, dependent: :destroy
	validates :name, length: {maximum: 20} 
	accepts_nested_attributes_for :tasks	
end
