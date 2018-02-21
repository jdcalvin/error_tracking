class Task < ActiveRecord::Base
	before_save {self.description = description.capitalize}
  
  belongs_to :category, inverse_of: :tasks
  has_many :validations, dependent: :destroy
  has_many :orders, through: :validations
  validates :description, presence: true
  validates :category, presence: true

	delegate :order_type, :to => :category
end
