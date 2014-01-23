class Validation < ActiveRecord::Base
  belongs_to :task
  belongs_to :order
  validates :approval, inclusion: [true, false]
end
