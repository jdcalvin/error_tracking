class Order < ActiveRecord::Base
  belongs_to :order_type
  validates :order_type, presence: true
  has_many :validations, dependent: :destroy
  has_many :tasks, through: :order_type
  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :validations
  default_scope -> { order('created_at ASC') }

end
