class Order < ActiveRecord::Base
  belongs_to :order_type
  belongs_to :user
  cattr_accessor :skip_callbacks
  validates :order_type, presence: true
  validates :order_name, presence: true
  has_many :validations, dependent: :destroy
  has_many :tasks, through: :validations
  has_many :categories, through: :tasks
  accepts_nested_attributes_for :validations
  
  def self.date(date)
    where(created_at: date)
    .includes(:validations).includes(:tasks).includes(:categories)
  end

  def show_errors
  	show_errors = validations.select {|x| x.approval}
  	hash = Hash.new{|h,k| h[k] = []}
	  show_errors.each {|x| hash[x.category_name] << x.task_description }
  	return hash
  end

  def errors?
    if validations.select {|x| x.approval}.any?
      update_attributes(error:true)
    else
      unless self.error == false
        update_attributes(error:false)
      end
    end
    return error
  end

  def self.with_errors
    with_errors = self.where(error: true)
  end

  def self.breakdown
    new_hash = Hash.new(0)
    hash = Hash.new{|h, k| h[k] = []}
    self.with_errors.each do |order|
      order.show_errors.each_pair do |k,v|
        hash[k] << v
      end
    end

    hash.each do |x|
      new_hash[x[0]] = x[1].flatten
    end
    new_hash.each_pair do |key, value|
      res = Hash[value.group_by {|x| x}.map {|k, v| [k,v.count]}]
      new_hash[key] = res
    end

    return new_hash
  end

  def self.search(search)
    if search
      where("order_name ilike :q", q: "%#{search}%").order('order_name ASC')
    else
      scoped
    end  
  end
end
