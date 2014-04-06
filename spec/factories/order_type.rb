FactoryGirl.define do
	factory :order_type do
		sequence(:title) {|n| "Type #{n}" }
		association :organization
	end
end

