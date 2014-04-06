FactoryGirl.define do
	factory :order_type do
		sequence(:title) {|n| "Type #{n}" }
		organization
	end
end

