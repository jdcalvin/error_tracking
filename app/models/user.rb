class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save {self.first_name = first_name.split.map {|x| x.capitalize }.join(" ") }
  before_save {self.last_name = last_name.split.map {|x| x.capitalize }.join(" ") }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
end
