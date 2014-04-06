FactoryGirl.define do
	factory :category do
		sequence(:name) {|n| "Category #{n}" }
		order_type
	end
end
