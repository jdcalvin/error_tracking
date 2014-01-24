class Validation < ActiveRecord::Base
  belongs_to :task
  belongs_to :order
  validates :approval, inclusion: [true, false]
  #validates :task_id, presence: true
end
