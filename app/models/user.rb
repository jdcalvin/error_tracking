class User < ActiveRecord::Base
  before_save {self.first_name = first_name.split.map {|x| x.capitalize }.join(" ") }
  before_save {self.last_name = last_name.split.map {|x| x.capitalize }.join(" ") }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
	validates :last_name, presence: true
  
  has_many :orders
  belongs_to :organization
  has_many :order_types, through: :organization

  def full_name
    return "#{first_name} #{last_name}"
  end

  def reverse_name
    return "#{last_name}, #{first_name}"
  end

  def self.admins?
  	self.select {|user| user.admin}
  end
  	
  def active_for_authentication?
    super && self.active
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end

end


