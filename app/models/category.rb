class Category < ActiveRecord::Base
	before_save {self.name = name.split.map {|x| x.capitalize }.join(" ") }
	has_many :tasks, dependent: :destroy
	validates :name, length: {maximum: 20} 

	def self.convert_to_id(name)
		name = Category.find_by(name: name)
		name.id
	end
	
end
