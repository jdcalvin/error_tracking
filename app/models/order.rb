class Order < ActiveRecord::Base
  belongs_to :order_type, inverse_of: :orders
  belongs_to :user
  cattr_accessor :skip_callbacks
  validates :order_type, presence: true
  validates :order_name, presence: true
  validates :user, presence: true
  validates_presence_of :note, 
                        :if      => :require_note,
                        :message => "can't be empty if errors are present"

  has_many :validations, dependent: :destroy, inverse_of: :order
  has_many :tasks, through: :validations
  has_many :categories, through: :tasks
  accepts_nested_attributes_for :validations

  extend Searchable
  
  def self.date(date)
    where(created_at: date)
    .includes(:validations => { :task => :category})
  end

  def date
    arr = [self.created_at.day, self.created_at.month, self.created_at.year]
  end
    
  def show_errors
    Tracking::ErrorBreakdown.by_order(self)
  end

  def errors?
    validations.select {|x| x.approval }.any?  
  end

  def self.with_errors
    with_errors = self.where(error: true)
  end

  def self.breakdown
    Tracking::ErrorBreakdown.by_orders(self)
  end

  def self.search(search)
    search_by(:order_name, search)
  end

  def require_note
    new_record? ? error : errors?
  end

end
