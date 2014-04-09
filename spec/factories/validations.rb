FactoryGirl.define do
	factory :validation do
		association :task
		association :order
		approval :false
		
		trait :has_error do
			approval true
		end
	end
end