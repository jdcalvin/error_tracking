class Task < ActiveRecord::Base
	before_save {self.description = description.capitalize}
  belongs_to :category 
  belongs_to :order_type
  has_many :validations
  has_many :orders, through: :validations
  validates :description, :category_id, presence: true
  # validates :category, inclusion: { in: 27..33 }, presence: true

  def self.convert_to_id

  end

  def self.cat_name
  end

  
end
