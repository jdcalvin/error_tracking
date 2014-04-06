FactoryGirl.define do
	factory :order do
		sequence(:order_name) {|n| "TST00#{n}" }
		association :order_type
		association :user
		error false
		trait :with_error do
			error true
			note "Only relevant if error is present"
		end
	end
end

