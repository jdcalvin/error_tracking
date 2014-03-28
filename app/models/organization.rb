class Organization < ActiveRecord::Base
	has_many :order_types
	has_many :users
end
