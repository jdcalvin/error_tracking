class Task < ActiveRecord::Base
	before_save {self.description = description.capitalize}
  belongs_to :category 
  has_many :validations, dependent: :destroy
  has_many :orders, through: :validations
  validates :description, presence: true
	delegate :order_type, :to => :category
end
