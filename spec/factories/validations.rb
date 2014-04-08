FactoryGirl.define do
	factory :validation do
		association :task
		association :order
		trait :has_error do
			approval true
		end
		trait :no_error do
			approval false
		end
	end
end