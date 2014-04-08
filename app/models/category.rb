class Category < ActiveRecord::Base
	before_save {self.name = name.split.map {|x| x.capitalize }.join(" ") }
	belongs_to :order_type, inverse_of: :categories
	has_many :tasks, dependent: :destroy, inverse_of: :category
	validates :name, length: {maximum: 20}, presence: true
 	validates :order_type, presence: true	
	accepts_nested_attributes_for :tasks, allow_destroy: true,
		reject_if: lambda {|x| x[:description].blank? }

end
