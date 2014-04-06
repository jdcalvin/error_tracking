class Category < ActiveRecord::Base
	before_save {self.name = name.split.map {|x| x.capitalize }.join(" ") }
	belongs_to :order_type
	has_many :tasks, dependent: :destroy
	validates :name, length: {maximum: 20}, presence: true
 	validates :order_type_id, presence: true	
	accepts_nested_attributes_for :tasks, allow_destroy: true,
		reject_if: lambda {|x| x[:description].blank? }

end
