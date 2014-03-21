class Organization < ActiveRecord::Base
	has_many :order_types
end
