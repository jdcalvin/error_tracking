FactoryGirl.define do
	factory :order do
		sequence(:order_name) {|n| "TST00#{n}" }
		order_type
		user
		error false
		trait :with_error do
			error true
			note { Faker::Lorem.paragraph }
		end
	end
end

