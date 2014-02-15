class Task < ActiveRecord::Base
	before_save {self.description = description.capitalize}
  belongs_to :category 
  belongs_to :order_type
  has_many :validations, dependent: :destroy
  has_many :orders, through: :validations
  validates :description, :category_id, presence: true



end
