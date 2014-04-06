FactoryGirl.define do
	factory :organization do
		sequence(:title) {|n| "Organization #{n}"}
	end
end
