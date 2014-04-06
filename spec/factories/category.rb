FactoryGirl.define do
	factory :category do
		sequence(:name) {|n| "Category #{n}" }
		association :order_type
	end
end
